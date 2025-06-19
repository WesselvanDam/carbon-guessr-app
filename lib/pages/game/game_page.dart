import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'game_controller.dart';
import 'game_results_page.dart';
import 'local/game_app_bar.dart';
import 'local/game_round_form.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameControllerProvider);

    return Scaffold(
      appBar: const GameAppBar(),
      body: SingleChildScrollView(
        child: (game.value?.isCompleted ?? false)
            ? const GameResultsPage()
            : const GameRoundForm(),
      ),
    );
  }
}
