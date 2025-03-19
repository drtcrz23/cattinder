import 'package:flutter/material.dart';
import '../models/cat.dart';
import '../pages/cat_description_screens.dart';

class FavoritesScreen extends StatefulWidget {
  final ValueNotifier<List<Cat>> likedCatsNotifier;
  final Function(Cat) onRemoveLike;

  const FavoritesScreen({
    super.key,
    required this.likedCatsNotifier,
    required this.onRemoveLike,
  });

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with TickerProviderStateMixin {
  late List<Cat> _likedCats;
  final Map<int, AnimationController> _animationControllers = {};
  final Map<int, Animation<Offset>> _slideAnimations = {};

  @override
  void initState() {
    super.initState();
    _likedCats = List.from(widget.likedCatsNotifier.value);
    widget.likedCatsNotifier.addListener(_updateLikedCats);

    for (int i = 0; i < _likedCats.length; i++) {
      _createAnimation(i);
    }
  }

  @override
  void dispose() {
    widget.likedCatsNotifier.removeListener(_updateLikedCats);

    for (final controller in _animationControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateLikedCats() {
    setState(() {
      _likedCats = List.from(widget.likedCatsNotifier.value);

      _animationControllers.clear();
      _slideAnimations.clear();

      for (int i = 0; i < _likedCats.length; i++) {
        _createAnimation(i);
      }
    });
  }

  void _createAnimation(int index) {
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    final animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    _animationControllers[index] = controller;
    _slideAnimations[index] = animation;

    Future.delayed(Duration(milliseconds: index * 100), () {
      if (mounted) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked cats ❤️'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFD9CFF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _likedCats.isEmpty
            ? const Center(
          child: Text(
            'There are no liked cats 😿',
            style: TextStyle(fontSize: 18),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _likedCats.length,
          itemBuilder: (context, index) {
            final cat = _likedCats[index];
            return SlideTransition(
              position: _slideAnimations[index]!,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CatDetailsScreen(cat: cat),
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        cat.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                    title: Text(
                      cat.breedName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            widget.onRemoveLike(cat);
                          },
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}