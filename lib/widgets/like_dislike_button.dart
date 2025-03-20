import 'package:flutter/material.dart';

class LikeButtons extends StatelessWidget {
  const LikeButtons({
    super.key,
    required this.onLike,
    required this.onDislike,
    required this.likeCounter,
    required this.dislikeCounter,
    this.isDisabled = false, // По умолчанию false
  });

  final VoidCallback onLike;
  final VoidCallback onDislike;
  final ValueNotifier<int> likeCounter;
  final ValueNotifier<int> dislikeCounter;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0, // визуально показываем, что disabled
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.close, size: 40, color: Colors.pink),
                onPressed: isDisabled ? null : onDislike,
              ),
              ValueListenableBuilder<int>(
                valueListenable: dislikeCounter,
                builder: (context, count, child) {
                  return Text(
                    'dislikes: $count',
                    style: const TextStyle(fontSize: 14),
                  );
                },
              ),
            ],
          ),

          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite, size: 40, color: Colors.pink),
                onPressed: isDisabled ? null : onLike,
              ),
              ValueListenableBuilder<int>(
                valueListenable: likeCounter,
                builder: (context, count, child) {
                  return Text(
                    'likes: $count',
                    style: const TextStyle(fontSize: 14),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
