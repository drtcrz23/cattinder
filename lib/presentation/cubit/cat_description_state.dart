import '../../domain/entities/cat.dart';

abstract class CatDetailsState {}

class CatDetailsInitial extends CatDetailsState {}

class CatDetailsLoading extends CatDetailsState {}

class CatDetailsLoaded extends CatDetailsState {
  CatDetailsLoaded(this.cat);

  final Cat cat;
}

class CatDetailsError extends CatDetailsState {
  CatDetailsError(this.message);

  final String message;
}
