import '../../../domain/entities/cat.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded(this.cat, {this.likeCount = 0, this.dislikeCount = 0});

  final Cat cat;
  final int likeCount;
  final int dislikeCount;
}

class HomeLiked extends HomeState {
  HomeLiked(this.cat);

  final Cat cat;
}

class HomeDisliked extends HomeState {}

class HomeError extends HomeState {
  HomeError(this.message);

  final String message;
}

class HomeFatalError extends HomeState {
  HomeFatalError(this.message);

  final String message;
}
