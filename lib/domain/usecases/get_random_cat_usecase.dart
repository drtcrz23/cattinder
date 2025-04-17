import '../entities/cat.dart';
import '../repositories/cat_repository.dart';

class GetRandomCatUseCase {
  GetRandomCatUseCase(this.repository);
  final CatRepository repository;

  Future<Cat?> call() => repository.getRandomCat();
}
