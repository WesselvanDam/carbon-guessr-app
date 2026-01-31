import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../constants/game_mode.dart';
import '../../../../design_system/components/appbar.dart';
import '../../../../design_system/components/buttons/icon_buttons.dart';
import '../../../../design_system/components/chips/info_chip.dart';
import '../../../../design_system/styles/app_colors.dart';
import '../../../../design_system/styles/app_typography.dart';
import '../../controllers/game_controller.dart';
import '../../models/game.model.dart';
import '../../providers/game_providers.dart';
import 'game_time.dart';

class GameAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const GameAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameControllerProvider).value;
    final mode = ref.watch(gameModeProvider);
    final isCompleted = game?.isCompleted ?? false;

    return AppBar(
      children: [
        SquareIconButton(
          icon: Symbols.arrow_back,
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: AppColors.white,
          iconColor: AppColors.neutral400,
          borderColor: AppColors.neutral200,
        ),
        Expanded(
          child: Column(
            spacing: 4,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isCompleted) ...[
                RoundInfo(game: game, mode: mode),
                GameProgressBar(game: game),
              ] else ...[
                const Text('GAME SUMMARY', style: AppTypography.captionLarge),
              ],
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
          'ROUND ${(game?.currentRoundIndex ?? 0) + 1} OF ${game?.rounds.length ?? 5}',
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
          ),
          style: AppTypography.caption.copyWith(
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
                final progress =
                    ((game?.currentRoundIndex ?? 0) + 1) /
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
