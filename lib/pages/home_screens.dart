import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/cat_api_services.dart';
import '../models/cat.dart';
import '../pages/favorite_cats.dart';
import '../widgets/like_dislike_button.dart';
import '../presentation/screens/loading_screen.dart';
import '../pages/cat_description_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<List<Cat>> _likedCatsNotifier = ValueNotifier([]);
  final ValueNotifier<int> _likeCounter = ValueNotifier(0);
  final ValueNotifier<int> _dislikeCounter = ValueNotifier(0);

  Cat? _currentCat;
  bool _isLoading = true;
  String? _errorMessage;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _fetchNewCat();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _likedCatsNotifier.dispose();
    _likeCounter.dispose();
    _dislikeCounter.dispose();
    super.dispose();
  }

  bool _isCatAlreadyLiked(Cat cat) {
    return _likedCatsNotifier.value.any((likedCat) => likedCat.id == cat.id);
  }

  void _fetchNewCat() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final cat = await ApiService.fetchRandomCat();
      if (cat == null) {
        throw Exception('Failed to load a cat with breed.');
      }
      if (!mounted) return; // Check if widget is still in the tree
      await precacheImage(NetworkImage(cat.imageUrl), context);
      if (!mounted) return; // Check again before calling setState
      setState(() {
        _currentCat = cat;
        _isLoading = false;
      });

      _animationController.forward(from: 0);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _handleLike() {
    if (_currentCat != null && !_isCatAlreadyLiked(_currentCat!)) {
      _likedCatsNotifier.value = [..._likedCatsNotifier.value, _currentCat!];
      _likeCounter.value++;
    }
    HapticFeedback.lightImpact();
    _fetchNewCat();
  }

  void _handleDislike() {
    _dislikeCounter.value++;
    HapticFeedback.mediumImpact();
    _fetchNewCat();
  }

  void _openDetails() {
    if (_currentCat != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatDetailsScreen(cat: _currentCat!),
        ),
      );
    }
  }

  void _removeLike(Cat cat) {
    setState(() {
      _likedCatsNotifier.value =
          _likedCatsNotifier.value
              .where((likedCat) => likedCat.id != cat.id)
              .toList();
      _likeCounter.value--; // Уменьшаем счетчик лайков
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Cat Tinder 🐾'),
        backgroundColor: Colors.white.withAlpha(230),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.pinkAccent,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => FavoritesScreen(
                        likedCatsNotifier: _likedCatsNotifier,
                        onRemoveLike: _removeLike,
                      ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFD9CFF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child:
              _isLoading
                  ? const LoadingScreen()
                  : _errorMessage != null
                  ? _buildErrorMessage()
                  : _buildContent(),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Center(
      key: const ValueKey('error'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: Colors.red.shade400),
          const SizedBox(height: 20),
          Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.red.shade400),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: _fetchNewCat,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text('Try again', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      key: const ValueKey('content'),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOutBack,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _openDetails,
                  child: Dismissible(
                    key: ValueKey(_currentCat?.id ?? 'cat_card'),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        _handleLike();
                      } else if (direction == DismissDirection.endToStart) {
                        _handleDislike();
                      }
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade100.withAlpha(102),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 30),
                      child: const Icon(
                        Icons.favorite,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                    secondaryBackground: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent.shade100.withAlpha(102),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 30),
                      child: const Icon(
                        Icons.close,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      shadowColor: Colors.deepPurple.withAlpha(77),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: _currentCat!.imageUrl,
                              height: 300,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => Container(
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) =>
                                      _buildPlaceholderImage(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _currentCat!.breedName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: ValueListenableBuilder<int>(
                              valueListenable: _likeCounter,
                              builder: (context, likeCount, _) {
                                return ValueListenableBuilder<int>(
                                  valueListenable: _dislikeCounter,
                                  builder: (context, dislikeCount, _) {
                                    return LikeButtons(
                                      onLike: _handleLike,
                                      onDislike: _handleDislike,
                                      likeCounter: _likeCounter,
                                      dislikeCounter: _dislikeCounter,
                                      isDisabled: _isLoading,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 300,
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, size: 60, color: Colors.grey[600]),
          const SizedBox(height: 10),
          Text(
            'Image not available',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
