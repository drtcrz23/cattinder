import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/cat.dart';
import 'loading_screen.dart';
import '../cubit/home_cubit.dart';
import '../cubit/liked_cats_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/like_dislike_button.dart';
import '../screens/cat_description_screen.dart';
import '../screens/liked_cats_screen.dart';
import '../dialogs/error_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().loadCat();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _openDetails(Cat cat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CatDetailsScreen(cat: cat),
      ),
    );
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
            icon: const Icon(Icons.favorite, color: Colors.pinkAccent, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
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
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              showDialog(
                context: context,
                builder: (_) => ErrorDialog(
                  message: state.message,
                  onRetry: () {
                    context.read<HomeCubit>().loadCat();
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const LoadingScreen();
            } else if (state is HomeFatalError) {
              return _buildFatalErrorState(state.message);
            } else if (state is HomeLoaded) {
              final homeCubit = context.read<HomeCubit>();
              final favoritesCubit = context.watch<FavoritesCubit>();
              _animationController.forward(from: 0);

              if (state.cat.breedName.toLowerCase() == 'unknown') {
                homeCubit.loadCat();
                return const LoadingScreen();
              }

              return _buildContent(
                state.cat,
                homeCubit,
                favoritesCubit,
                state.likeCount,
                state.dislikeCount,
              );
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }

  Widget _buildContent(
      Cat cat,
      HomeCubit homeCubit,
      FavoritesCubit favoritesCubit,
      int likeCount,
      int dislikeCount,
      ) {
    return Center(
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
                  onTap: () => _openDetails(cat),
                  child: Dismissible(
                    key: ValueKey(cat.id),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        favoritesCubit.addFavorite(cat);
                        homeCubit.onLike(cat);
                        HapticFeedback.lightImpact();
                      } else {
                        homeCubit.incrementDislike();
                        HapticFeedback.mediumImpact();
                      }
                      HapticFeedback.selectionClick();
                      homeCubit.loadCat();
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade100.withAlpha(102),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 30),
                      child: const Icon(Icons.favorite, size: 40, color: Colors.green),
                    ),
                    secondaryBackground: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent.shade100.withAlpha(102),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 30),
                      child: const Icon(Icons.close, size: 40, color: Colors.red),
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
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: CachedNetworkImage(
                              imageUrl: cat.imageUrl,
                              height: 300,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                                child: const Center(child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) =>
                                  _buildPlaceholderImage(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              cat.breedName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            child: LikeButtons(
                              onLike: () {
                                favoritesCubit.addFavorite(cat);
                                homeCubit.onLike(cat);
                                homeCubit.loadCat();
                              },
                              onDislike: () {
                                homeCubit.incrementDislike();
                                homeCubit.loadCat();
                              },
                              likeCount: likeCount,
                              dislikeCount: dislikeCount,
                              isDisabled: false,
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
          Text('Image not available', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildFatalErrorState(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off, size: 80, color: Colors.redAccent),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.read<HomeCubit>().loadCat();
            },
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
