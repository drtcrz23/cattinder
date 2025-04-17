import 'package:get_it/get_it.dart';
import '../../data/services/cat_api_service.dart';
import '../../data/repositories/cat_repository_impl.dart';
import '../../data/services/liked_cats_service.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';
import '../../domain/usecases/get_random_cat_usecase.dart';
import '../../presentation/cubit/cat_description_cubit.dart';
import '../../presentation/cubit/home_cubit.dart';
import '../../presentation/cubit/liked_cats_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton(() => ApiService());
  sl.registerLazySingleton(() => LikeService());

  // Repositories
  sl.registerLazySingleton<CatRepository>(() => CatRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetRandomCatUseCase(sl()));
  sl.registerFactory(() => HomeCubit(sl(), sl()));
  sl.registerFactory(() => FavoritesCubit(likeService: sl()));

  sl.registerFactoryParam<CatDetailsCubit, Cat, void>(
    (cat, _) => CatDetailsCubit(cat),
  );
}
