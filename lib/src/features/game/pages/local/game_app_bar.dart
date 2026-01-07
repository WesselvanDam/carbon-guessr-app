import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../shared/design_system/app_colors.dart';
import '../../../../shared/design_system/app_typography.dart';
import '../../../../shared/widgets/buttons/icon_buttons.dart';
import '../../../../shared/utils/extensions.dart';
import '../../../collection/providers/current_collection.dart';
import '../../controllers/game_controller.dart';
import '../../providers/game_providers.dart';
import 'game_time.dart';

class GameAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const GameAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameControllerProvider).value;
    final collection = ref.watch(currentCollectionProvider).value;
    final mode = ref.watch(gameModeProvider);
    final isCompleted = game?.isCompleted ?? false;

    return Container(
      color: AppColors.bg.withOpacity(0.95),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              // Back/Exit button
              SquareIconButton(
                icon: Symbols.close,
                onPressed: () => Navigator.of(context).pop(),
                size: 48,
                iconSize: 24,
                borderRadius: 16,
                backgroundColor: AppColors.surface,
                iconColor: AppColors.slate400,
                borderColor: AppColors.slate200,
              ),
              const SizedBox(width: 12),
              // Progress bar and info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Round info and mode badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isCompleted
                              ? 'GAME COMPLETED!'
                              : 'ROUND ${(game?.currentRoundIndex ?? 0) + 1} OF ${game?.rounds.length ?? 5}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textLight,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.slate200,
                            border: Border.all(
                              color: AppColors.slate300.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${mode.name.toTitleCase()} Mode',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.slate600,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Progress bar
                    if (!isCompleted)
                      Container(
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.slate200,
                          ),
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
                                    colors: [
                                      Color(0x10000000),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              // Progress indicator
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final progress =
                                      ((game?.currentRoundIndex ?? 0) + 1) /
                                          (game?.rounds.length ?? 5);
                                  return Container(
                                    width: constraints.maxWidth * progress,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(7),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x1A000000),
                                          offset: Offset(0, 2),
                                          blurRadius: 0,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Timer
              const GameTime(),
            ],
          ),
        ),
      ),
    );
  }
}
