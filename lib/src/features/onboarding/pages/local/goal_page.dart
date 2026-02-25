import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/collection.model.dart';
import '../../../../design_system/styles/app_typography.dart';
import '../../../home/pages/local/collection_card.dart';

class GoalPage extends ConsumerWidget {
  const GoalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Text('Trust Your Instincts', style: AppTypography.h2),
          Text(
            'Size up real-world facts to see how well you know the big picture.',
            style: AppTypography.h4,
          ),
          Text(
            'Choose a topic to explore — like the surface area of countries below — and compare items to guess the true scale between them.',
            style: AppTypography.bodyLarge,
          ),
          IgnorePointer(
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
