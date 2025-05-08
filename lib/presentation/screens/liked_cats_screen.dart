import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/cubit/liked_cats_cubit.dart';
import '../../presentation/screens/cat_description_screen.dart';
import '../cubit/liked_cats_state.dart';
import '../dialogs/error_dialog.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked cats ❤️'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              final breeds = [
                'All',
                ...state.cats.map((e) => e.breedName).toSet().toList()..sort(),
              ];
              return SizedBox(
                width: 150,
                child: DropdownButton<String>(
                  value: state.selectedBreed ?? 'All',
                  hint: const Text('All'),
                  isExpanded: true,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<FavoritesCubit>().filterByBreed(value);
                    }
                  },
                  items:
                      breeds.map((breed) {
                        return DropdownMenuItem<String>(
                          value: breed,
                          child: Text(
                            breed,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        );
                      }).toList(),
                ),
              );
              // return DropdownButton<String>(
              //   value: state.selectedBreed ?? 'All',
              //   hint: const Text("Filter"),
              //   onChanged: (value) {
              //     if (value != null) {
              //       context.read<FavoritesCubit>().filterByBreed(value);
              //     }
              //   },
              //   items: breeds.map((breed) => DropdownMenuItem<String>(
              //     value: breed,
              //     child: Text(breed),
              //   )).toList(),
              //   // items: [
              //   //   const DropdownMenuItem<String>(
              //   //     value: null,
              //   //     child: Text("All breeds"),
              //   //   ),
              //   //   ...breeds.map((breed) => DropdownMenuItem<String>(
              //   //     value: breed,
              //   //     child: Text(breed),
              //   //   ))
              //   // ],
              // );
            },
          ),
        ],
      ),
      body: BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (context, state) {
          if (state.error != null) {
            showDialog(
              context: context,
              builder:
                  (_) => ErrorDialog(
                    message: state.error!,
                    onRetry: () {
                      context.read<FavoritesCubit>().reloadCats();
                    },
                  ),
            );
          }
        },
        builder: (context, state) {
          if (state.filteredCats.isEmpty) {
            return const Center(
              child: Text(
                'There are no liked cats 😿',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.filteredCats.length,
            itemBuilder: (context, index) {
              final cat = state.filteredCats[index];
              return GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatDetailsScreen(cat: cat),
                      ),
                    ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(204),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(102),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: cat.imageUrl,
                        cacheKey: cat.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported),
                            ),
                      ),
                    ),
                    title: Text(
                      cat.breedName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      cat.likedAt != null
                          ? 'Liked at: ${cat.likedAt!.toLocal().toString().split('.')[0]}'
                          : 'No like date',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed:
                          () => context.read<FavoritesCubit>().removeFavorite(
                            cat.id,
                          ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
