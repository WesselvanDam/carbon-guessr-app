import 'package:flutter/material.dart' hide Dialog;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../design_system/components/dialogs/dialog.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_typography.dart';
import '../controllers/game_controller.dart';
import '../models/game.model.dart';
import '../widgets/game_app_bar.dart';
import 'results_page.dart';
import 'round_form.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  Future<bool> _onBackPressed(BuildContext context, GameModel? game) async {
    // If the game is in progress, confirm before exiting
    if (game != null && !game.isCompleted) {
      final shouldExit =
          await showDialog<bool>(
            context: context,
            builder: (dialogContext) => Dialog(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exit Game',
                      style: AppTypography.h4.copyWith(
                        color: AppColors.neutral900,
                      ),
                    ),
                    Text(
                      'Are you sure you want to exit the game? Your progress will be lost.',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.neutral900,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 8,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.neutral500,
                            textStyle: AppTypography.labelLarge,
                          ),
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(false),
                          child: const Text('CANCEL'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.error500,
                            textStyle: AppTypography.labelLarge,
                          ),
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(true),
                          child: const Text('EXIT'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ) ??
          false;
      return shouldExit;
    }
    return true; // Allow navigation if game is completed or null
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = ref.watch(
      gameControllerProvider.select((game) => game.value?.isCompleted ?? false),
    );
    final game = ref.watch(gameControllerProvider).value;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldExit = await _onBackPressed(context, game);
          if (shouldExit && context.mounted) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.neutral50,
        appBar: GameAppBar(onBackPressed: () => _onBackPressed(context, game)),
        body: isCompleted ? const GameResultsPage() : const GameRoundPage(),
      ),
    );
  }
}
