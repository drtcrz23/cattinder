import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Network Error'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            context.read<HomeCubit>().cancelLoading();
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onRetry();
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
