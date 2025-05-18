import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/navigation/routes.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CarbonGuessr'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo/icon
              const Icon(
                Icons.eco,
                size: 80,
                color: Colors.green,
              ),

              const SizedBox(height: 24),

              Text(
                'Welcome to CarbonGuessr!',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              Text(
                'Test your knowledge about carbon footprints',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Play Game Button
              ElevatedButton.icon(
                onPressed: () => const GameModeSelectionRoute().go(context),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Play Game'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),

              const SizedBox(height: 24),

              // Browse Data Button
              OutlinedButton.icon(
                onPressed: () => const CollectionListRoute().go(context),
                icon: const Icon(Icons.eco),
                label: const Text('Browse Carbon Data'),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
