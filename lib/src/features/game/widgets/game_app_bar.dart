import 'package:flutter/material.dart' hide AppBar, Dialog;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../constants/game_mode.dart';
import '../../../design_system/components/appbar.dart';
import '../../../design_system/components/buttons/icon_buttons.dart';
import '../../../design_system/components/chips/info_chip.dart';
import '../../../design_system/components/progress_bar.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_typography.dart';
import '../controllers/game_controller.dart';
import '../models/game.model.dart';
import '../providers/game_providers.dart';
import 'game_time.dart';

class GameAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const GameAppBar({this.onBackPressed, super.key});

  final Future<bool> Function()? onBackPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameControllerProvider).value;
    final mode = ref.watch(gameModeProvider);

    return AppBar(
      children: [
        SquareIconButton(
          icon: Symbols.arrow_back,
          onPressed: () async {
            final shouldExit = await onBackPressed?.call() ?? true;
            if (shouldExit && context.mounted) {
              Navigator.of(context).pop();
            }
          },
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 200;
        final roundText = game?.isCompleted ?? false
            ? (isNarrow ? 'SUMMARY' : 'GAME SUMMARY')
            : '${isNarrow ? '' : 'ROUND '}${(game?.currentRoundIndex ?? 0) + 1} OF ${game?.rounds.length ?? 5}';

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              roundText,
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
              ),
              style: AppTypography.captionSmall.copyWith(
                color: AppColors.neutral500,
                fontSize: 14,
                fontVariations: const [FontVariation('wght', 900)],
              ),
            ),
            InfoChip.neutral(label: '${mode.name.toUpperCase()}${isNarrow ? '' : ' MODE'}'),
          ],
        );
      },
    );
  }
}

class GameProgressBar extends StatelessWidget {
  const GameProgressBar({required this.game, super.key});

  final GameModel? game;

  @override
  Widget build(BuildContext context) {
    // Calculate progress from game state
    final progress = (game?.isCompleted ?? false)
        ? 1.0
        : (game?.currentRoundIndex ?? 0) / (game?.rounds.length ?? 5);

    return ProgressBar(progress: progress);
  }
}
