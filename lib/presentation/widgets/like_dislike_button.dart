import 'package:flutter/material.dart';

class LikeButtons extends StatelessWidget {
  const LikeButtons({
    super.key,
    required this.onLike,
    required this.onDislike,
    required this.likeCount,
    required this.dislikeCount,
    this.isDisabled = false,
  });

  final VoidCallback onLike;
  final VoidCallback onDislike;
  final int likeCount;
  final int dislikeCount;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.close, size: 40, color: Colors.pink),
                onPressed: isDisabled ? null : onDislike,
              ),
              Text('dislikes: $dislikeCount', style: const TextStyle(fontSize: 14)),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite, size: 40, color: Colors.pink),
                onPressed: isDisabled ? null : onLike,
              ),
              Text('likes: $likeCount', style: const TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
