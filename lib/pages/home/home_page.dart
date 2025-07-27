import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../router/routes.dart';
import 'local/select_collection.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.question_mark),
                  onPressed: () {
                    // Navigate to the onboarding page
                    const OnboardingRoute().go(context);
                  },
                  tooltip: 'Help',
                ),
              ],
            ),
            const SizedBox(height: 48),
            // App logo/icon
            const Icon(
              Icons.eco,
              size: 80,
              color: Colors.green,
            ),

            const SizedBox(height: 24),

            Text(
              'Welcome to QuoScient!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            Text(
              'Train your intuition',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),

            // Collections List
            const Expanded(
              child: CollectionSelector(),
            ),
          ],
        ),
      ),
    );
  }
}
