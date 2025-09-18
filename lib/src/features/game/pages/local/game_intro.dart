import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../router/router.dart';
import '../../../collection/providers/collection_providers.dart';

class GameIntro extends ConsumerWidget {
  const GameIntro({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cid = ref.watch(routerProvider.select(
      (router) => router.state.pathParameters['cid'] ?? '',
    ));
    final collection = ref.watch(collectionProvider(cid)).value;

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
