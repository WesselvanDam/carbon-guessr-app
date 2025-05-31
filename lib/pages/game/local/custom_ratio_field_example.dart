import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'custom_ratio_field.dart';

/// Example page demonstrating the use of the CustomRatioField
class RatioFieldExamplePage extends ConsumerStatefulWidget {
  const RatioFieldExamplePage({super.key});

  @override
  ConsumerState<RatioFieldExamplePage> createState() =>
      _RatioFieldExamplePageState();
}

class _RatioFieldExamplePageState extends ConsumerState<RatioFieldExamplePage> {
  double _currentRatio = 2.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Ratio Field Example'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Example 1: Basic Custom Ratio Field',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                CustomRatioField(
                  initialRatio: 2.0,
                  firstItemTitle: 'Item A',
                  secondItemTitle: 'Item B',
                  firstItemColor: Colors.blue,
                  secondItemColor: Colors.green,
                  onRatioChanged: (ratio) {
                    debugPrint('New ratio: $ratio');
                  },
                ),
                const SizedBox(height: 32),
                const Text(
                  'Example 2: Combined Ratio Field with Text Input',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                CombinedRatioField(
                  initialRatio: _currentRatio,
                  firstItemTitle: 'Car',
                  secondItemTitle: 'Bicycle',
                  firstItemColor: Colors.red,
                  secondItemColor: Colors.purple,
                  onRatioChanged: (ratio) {
                    setState(() {
                      _currentRatio = ratio;
                    });
                    debugPrint('Combined ratio changed: $ratio');
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'Current Ratio: ${_currentRatio.toStringAsFixed(2)}:1',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Entry point to show the example page
void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: RatioFieldExamplePage(),
      ),
    ),
  );
}
