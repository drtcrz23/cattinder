import 'package:bloc/bloc.dart';
import '../../data/services/liked_cats_service.dart';
import '../../domain/entities/cat.dart';
import 'liked_cats_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required this.likeService})
    : super(FavoritesState.initial()) {
    _init();
  }

  final LikeService likeService;

  void _init() {
    likeService.addListener(_onLikesChanged);
    _onLikesChanged();
  }

  void _onLikesChanged() {
    final liked = likeService.likedCats;
    final selected = state.selectedBreed;

    final filtered =
        selected == null || selected == 'All'
            ? liked
            : liked.where((cat) => cat.breedName == selected).toList();

    emit(state.copyWith(cats: liked, filteredCats: filtered));
  }

  void addFavorite(Cat cat) {
    final updatedCat = cat.copyWith(likedAt: DateTime.now());
    emit(
      state.copyWith(
        cats: [...state.cats, updatedCat],
        filteredCats: _applyFilter([
          ...state.cats,
          updatedCat,
        ], state.selectedBreed),
      ),
    );
    likeService.addLike(cat);
    // homeCubit.incrementLike();
  }

  void removeFavorite(String catId) {
    final updatedCats = state.cats.where((cat) => cat.id != catId).toList();

    final availableBreeds = updatedCats.map((e) => e.breedName).toSet();
    String? newSelectedBreed = state.selectedBreed;
    if (!availableBreeds.contains(state.selectedBreed)) {
      newSelectedBreed = 'All';
    }

    final filtered =
        newSelectedBreed == 'All'
            ? updatedCats
            : updatedCats
                .where((cat) => cat.breedName == newSelectedBreed)
                .toList();

    emit(
      state.copyWith(
        cats: updatedCats,
        filteredCats: filtered,
        selectedBreed: newSelectedBreed,
      ),
    );
    likeService.removeLike(catId);
    // homeCubit.decrementLike();
  }

  void filterByBreed(String breed) {
    if (breed == 'All') {
      emit(state.copyWith(selectedBreed: 'All', filteredCats: state.cats));
    } else {
      final filtered =
          state.cats.where((cat) => cat.breedName == breed).toList();
      emit(state.copyWith(selectedBreed: breed, filteredCats: filtered));
    }
  }

  void clearError() {
    emit(state.copyWith());
  }

  List<Cat> _applyFilter(List<Cat> cats, String? breed) {
    if (breed == null || breed == 'All') return cats;
    return cats.where((cat) => cat.breedName == breed).toList();
  }

  void reloadCats() {
    _onLikesChanged();
  }
}
