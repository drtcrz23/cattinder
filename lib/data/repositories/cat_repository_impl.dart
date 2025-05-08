import 'dart:async';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:drift/drift.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';
import '../database/database.dart';
import '../services/cat_api_service.dart';
import '../services/network_service.dart';

class CatRepositoryImpl implements CatRepository {
  CatRepositoryImpl(this._apiService, this._database, this._networkService);

  final ApiService _apiService;
  final AppDatabase _database;
  final NetworkService _networkService;

  final List<Cat> _preloadedCats = [];

  Future<void> _cacheImage(String imageUrl, String id) async {
    final cacheManager = DefaultCacheManager();
    await cacheManager.downloadFile(imageUrl, key: imageUrl);
  }

  @override
  Future<Cat?> getRandomCat() =>
      getCatsBatch(1).then((list) => list.isNotEmpty ? list.first : null);

  @override
  Future<List<Cat>> getCatsBatch(int count) async {
    try {
      if (_preloadedCats.length >= count) {
        final batch = _preloadedCats.sublist(0, count);
        _preloadedCats.removeRange(0, count);
        return batch;
      }

      final hasConnection = await _networkService.isConnected;

      if (hasConnection) {
        final models = await _apiService.fetchRandomCatsBatch(limit: count);
        final cats = <Cat>[];

        for (final model in models) {
          if (model.imageUrl.isEmpty || !Uri.parse(model.imageUrl).isAbsolute) {
            continue;
          }
          unawaited(_cacheImage(model.imageUrl, model.id));
          cats.add(model);
        }

        _preloadedCats.addAll(cats);

        final batch = _preloadedCats.sublist(0, count);
        _preloadedCats.removeRange(0, count);
        return batch;
      } else {
        final query =
            _database.select(_database.cachedCats)
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.cachedAt,
                  mode: OrderingMode.desc,
                ),
              ])
              ..limit(count);
        final rows = await query.get();

        if (rows.isEmpty) {
          return [];
        }

        return rows.map((cached) {
          return Cat(
            id: cached.id,
            imageUrl: cached.imageUrl,
            breedName: cached.breedName,
            description: cached.description,
            temperament: cached.temperament,
            origin: cached.origin,
          );
        }).toList();
      }
    } catch (e) {
      throw Exception('Failed to load cats batch: $e');
    }
  }
}
