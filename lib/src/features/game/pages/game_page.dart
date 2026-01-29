import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../design_system/styles/app_colors.dart';
import '../controllers/game_controller.dart';
import 'results_page.dart';
import 'round_form.dart';
import 'local/game_app_bar.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = ref.watch(
      gameControllerProvider.select((game) => game.value?.isCompleted ?? false),
    );
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      appBar: const GameAppBar(),
      body: isCompleted ? const GameResultsPage() : const GameRoundPage(),
    );
  }
}
