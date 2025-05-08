import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/database/database.dart';
import '../../data/services/cat_api_service.dart';
import '../../data/repositories/cat_repository_impl.dart';
import '../../data/services/liked_cats_service.dart';
import '../../data/services/network_service.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';
import '../../domain/usecases/get_cats_batch_usecase.dart';
import '../../domain/usecases/get_random_cat_usecase.dart';
import '../../presentation/cubit/cat_description_cubit.dart';
import '../../presentation/cubit/home_cubit.dart';
import '../../presentation/cubit/liked_cats_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerSingleton<AppDatabase>(AppDatabase());

  // Services
  sl.registerLazySingleton(() => ApiService());
  sl.registerLazySingleton(() => NetworkService());
  sl.registerLazySingleton(() => LikeService(sl()));

  // Repositories
  sl.registerLazySingleton<CatRepository>(
    () => CatRepositoryImpl(
      sl<ApiService>(),
      sl<AppDatabase>(),
      sl<NetworkService>(),
    ),
  );
  // UseCases
  sl.registerLazySingleton(() => GetRandomCatUseCase(sl()));
  sl.registerLazySingleton(() => GetCatsBatchUseCase(sl()));

  sl.registerFactory(
    () => HomeCubit(
      sl<GetCatsBatchUseCase>(),
      sl<LikeService>(),
      sl<NetworkService>(),
    ),
  );
  sl.registerFactory(() => FavoritesCubit(likeService: sl()));

  sl.registerFactoryParam<CatDetailsCubit, Cat, void>(
    (cat, _) => CatDetailsCubit(cat),
  );
}
