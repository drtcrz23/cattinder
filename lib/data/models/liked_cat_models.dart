import '../../domain/entities/cat.dart';

class LikedCat {
  LikedCat({required this.cat, required this.likedAt});
  final Cat cat;
  final DateTime likedAt;
}