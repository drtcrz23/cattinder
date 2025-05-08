import '../../../domain/entities/cat.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded({
    required this.currentCat,
    this.likeCount = 0,
    this.dislikeCount = 0,
  });
  final Cat currentCat;
  final int likeCount;
  final int dislikeCount;

  HomeLoaded copyWith({Cat? currentCat, int? likeCount, int? dislikeCount}) {
    return HomeLoaded(
      currentCat: currentCat ?? this.currentCat,
      likeCount: likeCount ?? this.likeCount,
      dislikeCount: dislikeCount ?? this.dislikeCount,
    );
  }

  @override
  List<Object?> get props => [currentCat, likeCount, dislikeCount];
}

class HomeError extends HomeState {
  HomeError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class HomeFatalError extends HomeState {
  HomeFatalError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
