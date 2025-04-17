import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/di/service_locator.dart';
import '../cubit/cat_description_cubit.dart';
import '../cubit/cat_description_state.dart';
import '../dialogs/error_dialog.dart';
import '../../../domain/entities/cat.dart';

class CatDetailsScreen extends StatelessWidget {
  const CatDetailsScreen({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CatDetailsCubit>(param1: cat)..loadCat(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<CatDetailsCubit, CatDetailsState>(
            builder: (context, state) {
              if (state is CatDetailsLoaded) {
                return Text(state.cat.breedName);
              }
              return const Text('Loading...');
            },
          ),
        ),
        body: BlocListener<CatDetailsCubit, CatDetailsState>(
          listener: (context, state) {
            if (state is CatDetailsError) {
              showDialog(
                context: context,
                builder:
                    (_) => ErrorDialog(
                      message: state.message,
                      onRetry: () {
                        context.read<CatDetailsCubit>().loadCat();
                      },
                    ),
              );
            }
          },
          child: BlocBuilder<CatDetailsCubit, CatDetailsState>(
            builder: (context, state) {
              if (state is CatDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CatDetailsLoaded) {
                final cat = state.cat;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildCatImage(cat.imageUrl),
                      const SizedBox(height: 24),
                      _buildBreedName(cat.breedName),
                      const SizedBox(height: 30),
                      _buildInfoBlock(
                        icon: Icons.description,
                        title: 'Description',
                        content: cat.description ?? 'There is no description',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoBlock(
                        icon: Icons.mood,
                        title: 'Temperament',
                        content: cat.temperament ?? 'Unknown',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoBlock(
                        icon: Icons.public,
                        title: 'Origin',
                        content: cat.origin ?? 'Unknown',
                      ),
                    ],
                  ),
                );
              } else if (state is CatDetailsError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('Unknown state'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCatImage(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(77),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: 300,
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Container(
                height: 300,
                color: Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              ),
          errorWidget:
              (context, url, error) => Container(
                height: 300,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported, size: 60),
              ),
        ),
      ),
    );
  }

  Widget _buildBreedName(String breedName) {
    return Center(
      child: Text(
        breedName,
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoBlock({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.purple),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(content, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
