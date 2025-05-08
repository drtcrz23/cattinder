import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/cat.dart';
import '../../../domain/usecases/get_cats_batch_usecase.dart';
import '../../data/services/liked_cats_service.dart';
import '../../data/services/network_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getCatsBatch, this._likeService, this._networkService)
    : super(HomeInitial()) {
    _likeService.addListener(_onLikesChanged);
    _loadInitialBatch();
  }

  final GetCatsBatchUseCase _getCatsBatch;
  final LikeService _likeService;
  final NetworkService _networkService;

  final List<Cat> _catsPool = [];
  int _dislikeCount = 0;
  bool _offlineExhausted = false;

  Future<void> _loadInitialBatch() async {
    emit(HomeLoading());
    try {
      await _fetchBatch();
      _showNext();
    } catch (e) {
      emit(HomeError('Failed to load cats: $e'));
    }
  }

  Future<void> _fetchBatch() async {
    final hasConn = await _networkService.isConnected;
    if (!hasConn && _offlineExhausted) return;
    final batch = await _getCatsBatch(10);
    if (!hasConn) _offlineExhausted = true;
    _catsPool.addAll(batch);
  }

  Future<void> loadCat() async {
    if (state is HomeInitial) {
      await _loadInitialBatch();
    } else {
      final hasConnection = await _networkService.isConnected;
      if (!hasConnection && _offlineExhausted) {
        emit(
          HomeError(
            'Failed to load cat. Please check your internet connection.',
          ),
        );
        return;
      }
      await nextCat();
    }
  }

  Future<void> nextCat() async {
    if (_catsPool.isEmpty) {
      final hasConn = await _networkService.isConnected;
      if (!hasConn && _offlineExhausted) {
        emit(HomeFatalError('No internet connection. Try again later.'));
        return;
      }
      emit(HomeLoading());
      try {
        await _fetchBatch();
      } catch (_) {
        emit(
          HomeError(
            'Failed to load cat. Please check your internet connection.',
          ),
        );
        return;
      }
    }
    _showNext();
  }

  void _showNext() {
    if (_catsPool.isEmpty) {
      emit(HomeFatalError('No cats available.'));
      return;
    }
    final next = _catsPool.removeAt(0);
    emit(
      HomeLoaded(
        currentCat: next,
        likeCount: _likeService.likeCount,
        dislikeCount: _dislikeCount,
      ),
    );
  }

  void likeCurrentCat() {
    if (state is HomeLoaded) {
      _likeService.addLike((state as HomeLoaded).currentCat);
      nextCat();
    }
  }

  void dislikeCurrentCat() {
    _dislikeCount++;
    nextCat();
  }

  void resetCounters() {
    _catsPool.clear();
    _dislikeCount = 0;
    _offlineExhausted = false;
    _likeService.clearLikes();
    nextCat();
  }

  void _onLikesChanged() {
    if (state is HomeLoaded) {
      final s = state as HomeLoaded;
      emit(s.copyWith(likeCount: _likeService.likeCount));
    }
  }

  @override
  Future<void> close() {
    _likeService.removeListener(_onLikesChanged);
    return super.close();
  }

  void cancelLoading() {
    emit(HomeFatalError('No internet connection. Try again later.'));
  }
}
