import '../entities/cat.dart';

abstract class CatRepository {
  Future<Cat?> getRandomCat();
  Future<List<Cat>> getCatsBatch(int count);
}
