import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../collection/providers/current_collection.dart';

class GameIntro extends ConsumerWidget {
  const GameIntro({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(currentCollectionProvider).value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge,
            children: [
              const TextSpan(text: 'Compare the ratio in '),
              TextSpan(
                text: collection?.quantity,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: ' (expressed in '),
              TextSpan(
                text: collection?.unit,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: ') between the two items below.'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'You can type a value or pinch the squares to adjust the ratio.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
