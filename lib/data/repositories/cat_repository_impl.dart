import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';
import '../services/cat_api_service.dart';

class CatRepositoryImpl implements CatRepository {
  CatRepositoryImpl(this.apiService);
  final ApiService apiService;

  @override
  Future<Cat?> getRandomCat() async {
    final model = await apiService.fetchRandomCats();
    return model;
  }
}
