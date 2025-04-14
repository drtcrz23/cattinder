import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';

// class LikedCatsService extends ChangeNotifier implements ValueListenable<List<Cat>> {
//   final List<Cat> _likedCats = [];
//
//   @override
//   List<Cat> get value => _likedCats;
//
//   int get likeCount => _likedCats.length;
//
//   void addCat(Cat cat) {
//     _likedCats.add(cat.copyWith(likedAt: DateTime.now()));
//     notifyListeners();
//   }
//
//   void removeCat(String catId) {
//     _likedCats.removeWhere((cat) => cat.id == catId);
//     notifyListeners();
//   }
//
//   void clear() {
//     _likedCats.clear();
//     notifyListeners();
//   }
// }



class LikeService extends ChangeNotifier {
  final List<Cat> _likedCats = [];

  List<Cat> get likedCats => List.unmodifiable(_likedCats);
  int get likeCount => _likedCats.length;

  void addLike(Cat cat) {
    final exists = _likedCats.any((c) => c.id == cat.id);
    if (!exists) {
      final updated = cat.copyWith(likedAt: DateTime.now());
      _likedCats.add(updated);
      notifyListeners();
    }
  }

  void removeLike(String catId) {
    _likedCats.removeWhere((cat) => cat.id == catId);
    notifyListeners();
  }

  void clearLikes() {
    _likedCats.clear();
    notifyListeners();
  }
}