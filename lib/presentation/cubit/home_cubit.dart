import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/cat.dart';
import '../../../domain/usecases/get_random_cat_usecase.dart';
import '../../data/services/liked_cats_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // HomeCubit(this.getRandomCat) : super(HomeInitial());
  // final GetRandomCatUseCase getRandomCat;
  HomeCubit(this.getRandomCat, this.likeService) : super(HomeInitial()) {
    _init();
  }

  final GetRandomCatUseCase getRandomCat;
  final LikeService likeService;

  void _init() {
    likeService.addListener(_onLikesChanged);
  }

  void _onLikesChanged() {
    _refreshState();
  }

  int _likeCount = 0;
  int _dislikeCount = 0;

  Future<void> loadCat() async {
    emit(HomeLoading());

    try {
      Cat? cat;
      int tries = 0;
      const maxTries = 10;
      while (tries < maxTries) {
        cat = await getRandomCat();
        if (cat != null &&
            cat.breedName.trim().isNotEmpty &&
            cat.breedName.toLowerCase() != 'unknown') {
          break;
        }
        tries++;
      }

      if (cat == null ||
          cat.breedName.trim().isEmpty ||
          cat.breedName.toLowerCase() == 'unknown') {
        emit(HomeError('Could not find a cat with the specified breed.'));
      } else {
        emit(
          HomeLoaded(
            cat,
            likeCount: likeService.likeCount,
            dislikeCount: _dislikeCount,
          ),
        );
      }
    } catch (_) {
      emit(
        HomeError('Failed to load cat. Please check your internet connection.'),
      );
    }
  }

  void cancelLoading() {
    emit(HomeFatalError('No internet connection. Try again later.'));
  }

  void onLike(Cat cat) {
    likeService.addLike(cat);
    _refreshState();
  }

  void _refreshState() {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(
        HomeLoaded(
          current.cat,
          likeCount: likeService.likeCount,
          dislikeCount: _dislikeCount,
        ),
      );
    }
  }

  void decrementLike() {
    if (_likeCount > 0) _likeCount--;
    _refreshLikeDislikeState();
  }

  void incrementDislike() {
    _dislikeCount++;
    _refreshLikeDislikeState();
  }

  void _refreshLikeDislikeState() {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      emit(
        HomeLoaded(
          current.cat,
          likeCount: _likeCount,
          dislikeCount: _dislikeCount,
        ),
      );
    }
  }

  void resetCounters() {
    likeService.clearLikes();
    _dislikeCount = 0;
    _refreshState();
  }
}
