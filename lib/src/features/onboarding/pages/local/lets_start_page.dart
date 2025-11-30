import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LetsStartPage extends ConsumerWidget {
  const LetsStartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseStyle = Theme.of(context).textTheme.bodyLarge!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Text(
            "Let's Train Your Intuition!",
            style: baseStyle.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'The more you play, the better your feeling for how different items compare will become.',
            style: baseStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'In the meantime, more collections and features are on their way, so stay tuned for updates! Ready to get started?',
            style: baseStyle,
          ),
        ],
      ),
    );
  }
}
