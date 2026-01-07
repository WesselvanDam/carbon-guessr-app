import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/collection.model.dart';
import '../../../home/pages/local/collection_card.dart';

class GoalPage extends ConsumerWidget {
  const GoalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseStyle = Theme.of(context).textTheme.bodyLarge!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Text(
            'The Goal',
            style: baseStyle.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'In Quoscient, your goal is to train your intuition when it comes to comparing different items based on specific quantities.',
            style: baseStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Items are grouped by collections, each focusing on a specific quantity. For example, you might explore a collection about the surface area of countries:',
            style: baseStyle,
          ),
          const IgnorePointer(
            child: CollectionCard(
              collection: CollectionModel(
                id: 'onboarding_collection',
                lastUpdated: '',
                title: 'Surface Area of Countries',
                tagline:
                    'Learn how countries compare in size by exploring their surface areas.',
                description: '',
                unit: 'km²',
                size: 195,
                quantity: 'Example Collection',
                ratioBoundary: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
