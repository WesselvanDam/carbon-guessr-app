import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/design_system/app_colors.dart';
import '../controllers/game_controller.dart';
import 'game_results_page.dart';
import 'game_round_form.dart';
import 'local/game_app_bar.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameControllerProvider);
    final isCompleted = game.value?.isCompleted ?? false;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const GameAppBar(),
      body: isCompleted
          ? Stack(
              children: [
                const GameResultsPage(),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: const GameResultsActions(),
                ),
              ],
            )
          : const GameRoundForm(),
    );
  }
}
