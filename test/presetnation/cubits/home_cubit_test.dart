import 'package:bloc_test/bloc_test.dart';
import 'package:cattinder/domain/entities/cat.dart';
import 'package:cattinder/presentation/cubit/home_cubit.dart';
import 'package:cattinder/presentation/cubit/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../mocks.dart';

void main() {
  late HomeCubit homeCubit;
  late MockGetCatsBatchUseCase mockGetCatsBatchUseCase;
  late MockLikeService mockLikeService;
  late MockNetworkService mockNetworkService;

  final testCat = Cat(
    id: '1',
    imageUrl: 'https://example.com/cat.jpg',
    breedName: 'Siamese',
  );

  setUpAll(() {
    registerFallbackValue(testCat);
  });

  setUp(() {
    mockGetCatsBatchUseCase = MockGetCatsBatchUseCase();
    mockLikeService = MockLikeService();
    mockNetworkService = MockNetworkService();

    homeCubit = HomeCubit(
      mockGetCatsBatchUseCase,
      mockLikeService,
      mockNetworkService,
    );

    when(() => mockNetworkService.isConnected).thenAnswer((_) async => true);
    when(() => mockLikeService.likeCount).thenReturn(0);
  });

  tearDown(() {
    homeCubit.close();
  });

  group('HomeCubit Tests', () {
    blocTest<HomeCubit, HomeState>(
      'emits [HomeLoading, HomeLoaded] when loadCat is successful',
      build: () {
        when(
          () => mockGetCatsBatchUseCase(any()),
        ).thenAnswer((_) async => [testCat]);
        return homeCubit;
      },
      act: (cubit) => cubit.loadCat(),
      expect: () => [isA<HomeLoading>(), isA<HomeLoaded>()],
    );

    blocTest<HomeCubit, HomeState>(
      'emits HomeFatalError when offline and cache is exhausted',
      build: () {
        when(
          () => mockNetworkService.isConnected,
        ).thenAnswer((_) async => false);
        when(() => mockGetCatsBatchUseCase(any())).thenAnswer((_) async => []);
        return homeCubit;
      },
      act: (cubit) => cubit.loadCat(),
      expect: () => [isA<HomeLoading>(), isA<HomeFatalError>()],
    );

    blocTest<HomeCubit, HomeState>(
      'increments like count and emits new HomeLoaded state on likeCurrentCat',
      build: () {
        when(
          () => mockGetCatsBatchUseCase(any()),
        ).thenAnswer((_) async => [testCat]);
        when(() => mockLikeService.addLike(any())).thenAnswer((_) async {});
        return homeCubit;
      },
      act: (cubit) async {
        await cubit.loadCat();
        cubit.likeCurrentCat();
      },
      expect:
          () => [
            isA<HomeLoading>(),
            isA<HomeLoaded>(),
            isA<HomeLoading>(),
            isA<HomeLoaded>(),
          ],
      verify: (_) {
        verify(() => mockLikeService.addLike(testCat)).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'increments dislike count and emits new HomeLoaded state on dislikeCurrentCat',
      build: () {
        when(
          () => mockGetCatsBatchUseCase(any()),
        ).thenAnswer((_) async => [testCat]);
        return homeCubit;
      },
      act: (cubit) async {
        await cubit.loadCat();
        cubit.dislikeCurrentCat();
      },
      expect:
          () => [
            isA<HomeLoading>(),
            isA<HomeLoaded>(),
            isA<HomeLoading>(),
            isA<HomeLoaded>(),
          ],
      verify: (_) {
        expect((homeCubit.state as HomeLoaded).dislikeCount, 1);
      },
    );
  });
}
