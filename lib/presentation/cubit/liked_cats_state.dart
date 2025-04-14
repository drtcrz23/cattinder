import 'package:equatable/equatable.dart';
import '../../domain/entities/cat.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.cats = const [],
    this.filteredCats = const [],
    this.selectedBreed,
    this.error,
  });

  factory FavoritesState.initial() {
    return const FavoritesState(
      cats: [],
      filteredCats: [],
      selectedBreed: null,
      error: null,
    );
  }

  final List<Cat> cats;
  final List<Cat> filteredCats;
  final String? selectedBreed;
  final String? error;

  FavoritesState copyWith({
    List<Cat>? cats,
    List<Cat>? filteredCats,
    String? selectedBreed,
    String? error,
  }) {
    return FavoritesState(
      cats: cats ?? this.cats,
      filteredCats: filteredCats ?? this.filteredCats,
      selectedBreed: selectedBreed ?? this.selectedBreed,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [cats, filteredCats, selectedBreed, error];
}
