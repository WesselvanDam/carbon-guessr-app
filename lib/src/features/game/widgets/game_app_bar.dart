import 'package:flutter/material.dart' hide AppBar, Dialog;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../constants/game_mode.dart';
import '../../../design_system/components/appbar.dart';
import '../../../design_system/components/buttons/icon_buttons.dart';
import '../../../design_system/components/chips/info_chip.dart';
import '../../../design_system/components/dialogs/dialog.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_typography.dart';
import '../controllers/game_controller.dart';
import '../models/game.model.dart';
import '../providers/game_providers.dart';
import 'game_time.dart';

class GameAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const GameAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);

  void _onBackPressed(BuildContext context, GameModel? game) {
    // If the game is in progress, confirm before exiting
    if (game != null && !game.isCompleted) {
      showDialog(
        context: context,
        builder: (dialogContext) => Dialog(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            child: Column(
              spacing: 16,
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Exit Game',
                  style: AppTypography.h4.copyWith(color: AppColors.neutral900),
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
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.error500,
                        textStyle: AppTypography.labelLarge,
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop(); // Close dialog
                        Navigator.of(context).pop(); // Exit game page
                      },
                      child: const Text('EXIT'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameControllerProvider).value;
    final mode = ref.watch(gameModeProvider);

    return AppBar(
      children: [
        SquareIconButton(
          icon: Symbols.arrow_back,
          onPressed: () => _onBackPressed(context, game),
          backgroundColor: AppColors.white,
          iconColor: AppColors.neutral400,
          borderColor: AppColors.neutral200,
        ),
        Expanded(
          child: Column(
            spacing: 4,
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundInfo(game: game, mode: mode),
              GameProgressBar(game: game),
            ],
          ),
        ),
        // Timer
        const GameTime(),
      ],
    );
  }
}

class RoundInfo extends StatelessWidget {
  const RoundInfo({required this.game, required this.mode, super.key});

  final GameModel? game;
  final GameMode mode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          game?.isCompleted ?? false
              ? 'GAME SUMMARY'
              : 'ROUND ${(game?.currentRoundIndex ?? 0) + 1} OF ${game?.rounds.length ?? 5}',
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
          ),
          style: AppTypography.captionSmall.copyWith(
            color: AppColors.neutral500,
            fontSize: 14,
            fontVariations: const [FontVariation('wght', 900)],
          ),
        ),
        InfoChip.neutral(label: '${mode.name.toUpperCase()} MODE'),
      ],
    );
  }
}

class GameProgressBar extends StatelessWidget {
  const GameProgressBar({required this.game, super.key});

  final GameModel? game;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Stack(
          children: [
            // Inner shadow effect
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x10000000), Colors.transparent],
                ),
              ),
            ),
            // Progress indicator
            LayoutBuilder(
              builder: (context, constraints) {
                debugPrint(
                  'Is completed: ${game?.isCompleted}. current ${game?.currentRoundIndex}',
                );
                final progress = (game?.isCompleted ?? false)
                    ? 1
                    : (game?.currentRoundIndex ?? 0) /
                          (game?.rounds.length ?? 5);
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: constraints.maxWidth * progress,
                  decoration: BoxDecoration(
                    color: AppColors.primary600,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: const [
                      BoxShadow(color: Color(0x1A000000), offset: Offset(0, 2)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
