import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../domain/entities/cat.dart';
import '../database/database.dart';

class LikeService extends ChangeNotifier {
  LikeService(this._db) {
    _loadLikes();
  }
  final AppDatabase _db;
  List<Cat> _likedCats = [];

  List<Cat> get likedCats => List.unmodifiable(_likedCats);
  int get likeCount => _likedCats.length;

  Future<void> _loadLikes() async {
    try {
      final likedRecords = await _db.select(_db.likedCats).get();

      _likedCats =
          likedRecords.map((liked) {
            return Cat(
              id: liked.id,
              imageUrl: liked.imageUrl,
              breedName: liked.breedName,
              description: liked.description,
              temperament: liked.temperament,
              origin: liked.origin,
              likedAt: liked.likedAt,
            );
          }).toList();

      notifyListeners();
    } catch (e) {
      'Error loading likes: $e';
    }
  }

  Future<void> addLike(Cat cat) async {
    if (_likedCats.any((c) => c.id == cat.id)) return;

    await _db
        .into(_db.likedCats)
        .insert(
          LikedCatsCompanion.insert(
            id: cat.id,
            imageUrl: cat.imageUrl,
            breedName: cat.breedName,
            description: Value(cat.description),
            temperament: Value(cat.temperament),
            origin: Value(cat.origin),
            likedAt: DateTime.now(),
          ),
        );

    _likedCats.add(cat.copyWith(likedAt: DateTime.now()));
    notifyListeners();
  }

  Future<void> removeLike(String catId) async {
    final cat = _likedCats.firstWhere((c) => c.id == catId);
    await (_db.delete(_db.likedCats)..where((t) => t.id.equals(catId))).go();

    final cacheManager = DefaultCacheManager();
    await cacheManager.removeFile(cat.imageUrl);

    _likedCats.removeWhere((c) => c.id == catId);
    notifyListeners();
  }

  Future<void> clearLikes() async {
    await _db.delete(_db.likedCats).go();

    _likedCats.clear();
    notifyListeners();
  }
}
