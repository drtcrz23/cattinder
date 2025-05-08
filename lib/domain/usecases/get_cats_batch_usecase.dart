import '../entities/cat.dart';
import '../repositories/cat_repository.dart';

class GetCatsBatchUseCase {
  GetCatsBatchUseCase(this.repository);
  final CatRepository repository;
  Future<List<Cat>> call(int count) => repository.getCatsBatch(count);
}
