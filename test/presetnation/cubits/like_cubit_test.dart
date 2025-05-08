import 'package:bloc_test/bloc_test.dart';
import 'package:cattinder/data/services/liked_cats_service.dart';
import 'package:cattinder/domain/entities/cat.dart';
import 'package:cattinder/presentation/cubit/liked_cats_cubit.dart';
import 'package:cattinder/presentation/cubit/liked_cats_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeCat extends Fake implements Cat {}

class MockLikeService extends Mock implements LikeService {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeCat());
  });

  late MockLikeService mockLikeService;
  late FavoritesCubit favoritesCubit;

  final testCat1 = Cat(
    id: '1',
    breedName: 'Abyssinian',
    imageUrl: 'url1',
    description: 'Desc1',
    temperament: 'Temp1',
    origin: 'Origin1',
  );

  final testCat2 = Cat(
    id: '2',
    breedName: 'Bengal',
    imageUrl: 'url2',
    description: 'Desc2',
    temperament: 'Temp2',
    origin: 'Origin2',
  );

  late List<Cat> likedCats;

  setUp(() {
    mockLikeService = MockLikeService();

    likedCats = [];

    when(() => mockLikeService.likedCats).thenAnswer((_) => likedCats);
    when(() => mockLikeService.addLike(any())).thenAnswer((invocation) async {
      final cat = invocation.positionalArguments[0] as Cat;
      likedCats.add(cat);
    });
    when(() => mockLikeService.removeLike(any())).thenAnswer((
      invocation,
    ) async {
      final id = invocation.positionalArguments[0] as String;
      likedCats.removeWhere((c) => c.id == id);
    });

    favoritesCubit = FavoritesCubit(likeService: mockLikeService);
  });

  tearDown(() => favoritesCubit.close());

  group('FavoritesCubit', () {
    blocTest<FavoritesCubit, FavoritesState>(
      'addFavorite should update state and call service',
      build: () => FavoritesCubit(likeService: mockLikeService),
      seed: () => const FavoritesState(selectedBreed: 'All'),
      act: (cubit) => cubit.addFavorite(testCat1),
      expect:
          () => [
            FavoritesState(
              cats: [testCat1],
              filteredCats: [testCat1],
              selectedBreed: 'All',
            ),
          ],
      verify: (_) {
        verify(() => mockLikeService.addLike(testCat1)).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'removeFavorite should update state and call service',
      build: () => FavoritesCubit(likeService: mockLikeService),
      seed:
          () => FavoritesState(
            cats: [testCat1, testCat2],
            filteredCats: [testCat1, testCat2],
            selectedBreed: 'All',
          ),
      act: (cubit) => cubit.removeFavorite(testCat1.id),
      expect:
          () => [
            FavoritesState(
              cats: [testCat2],
              filteredCats: [testCat2],
              selectedBreed: 'All',
            ),
          ],
      verify: (_) {
        verify(() => mockLikeService.removeLike(testCat1.id)).called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'filterByBreed with "All" should reset filtering',
      build: () => FavoritesCubit(likeService: mockLikeService),
      seed:
          () => FavoritesState(
            cats: [testCat1, testCat2],
            filteredCats: [testCat2],
            selectedBreed: 'Bengal',
          ),
      act: (cubit) => cubit.filterByBreed('All'),
      expect:
          () => [
            FavoritesState(
              cats: [testCat1, testCat2],
              filteredCats: [testCat1, testCat2],
              selectedBreed: 'All',
            ),
          ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'removeFavorite should reset breed filter if breed becomes unavailable',
      build: () => FavoritesCubit(likeService: mockLikeService),
      seed:
          () => FavoritesState(
            cats: [testCat1],
            filteredCats: [testCat1],
            selectedBreed: 'Abyssinian',
          ),
      act: (cubit) => cubit.removeFavorite(testCat1.id),
      expect: () => [const FavoritesState(selectedBreed: 'All')],
    );
  });

  group('Edge Cases', () {
    blocTest<FavoritesCubit, FavoritesState>(
      'removeFavorite should reset breed filter if breed becomes unavailable',
      build: () => FavoritesCubit(likeService: mockLikeService),
      seed:
          () => FavoritesState(
            cats: [testCat1],
            filteredCats: [testCat1],
            selectedBreed: 'Abyssinian',
          ),
      act: (cubit) => cubit.removeFavorite(testCat1.id),
      expect: () => [const FavoritesState(selectedBreed: 'All')],
    );
  });
}
