import 'package:cattinder/data/database/database.dart';
import 'package:cattinder/data/services/cat_api_service.dart';
import 'package:cattinder/data/services/liked_cats_service.dart';
import 'package:cattinder/data/services/network_service.dart';
import 'package:cattinder/domain/repositories/cat_repository.dart';
import 'package:cattinder/domain/usecases/get_cats_batch_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

class MockNetworkService extends Mock implements NetworkService {}

class MockAppDatabase extends Mock implements AppDatabase {}

class MockCatRepository extends Mock implements CatRepository {}

class MockGetCatsBatchUseCase extends Mock implements GetCatsBatchUseCase {}

class MockLikeService extends Mock implements LikeService {}
