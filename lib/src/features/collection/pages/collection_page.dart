import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../constants/game_mode.dart';
import '../../../../router/routes.dart';
import '../../../shared/design_system/app_colors.dart';
import '../../../shared/design_system/app_shadows.dart';
import '../../../shared/design_system/app_typography.dart';
import '../../../shared/utils/extensions.dart';
import '../../../shared/widgets/buttons/icon_buttons.dart';
import '../../game/repository/game_repository.dart';
import '../providers/current_collection.dart';
import 'challenge_dialog.dart';
import 'download_dialog.dart';

class CollectionPage extends ConsumerWidget {
  const CollectionPage({required this.cid, super.key});

  final String cid;

  /// Maps collection IDs to appropriate icons
  IconData _getCollectionIcon(String title, String id) {
    final titleLower = title.toLowerCase();
    final idLower = id.toLowerCase();

    if (titleLower.contains('food') ||
        titleLower.contains('kitchen') ||
        idLower.contains('food')) {
      return Symbols.restaurant;
    } else if (titleLower.contains('transport') || idLower.contains('transport')) {
      return Symbols.directions_car;
    } else {
      return Symbols.home_work;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(currentCollectionProvider);

    return collection.when(
      data: (info) {
        void startGameCallback(GameMode mode, [String? gameId]) => GameRoute(
          cid: info.id,
          gid: gameId ?? GameRepository.newGameId,
          mode: mode,
        ).go(context);

        return Scaffold(
          backgroundColor: AppColors.bg,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 16),
            child: Container(
              color: AppColors.bg.withOpacity(0.95),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SquareIconButton(
                        icon: Symbols.arrow_back,
                        onPressed: () => Navigator.of(context).pop(),
                        size: 48,
                        iconSize: 24,
                        borderRadius: 16,
                        backgroundColor: AppColors.surface,
                        iconColor: AppColors.slate400,
                        borderColor: AppColors.slate200,
                      ),
                      Text(
                        'COLLECTION',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Collection info card
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.slate100),
                      boxShadow: AppShadows.gameCard,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top accent bar
                        Container(
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(23),
                              topRight: Radius.circular(23),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and icon
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          info.title.toTitleCase(),
                                          style: AppTypography.h3.copyWith(
                                            color: AppColors.text,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.blue50,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            info.quantity.toSentenceCase().toUpperCase(),
                                            style: AppTypography.labelSmall.copyWith(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: AppColors.blue100,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppColors.blue100,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      _getCollectionIcon(info.title, info.id),
                                      size: 32,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Stats row
                              Row(
                                children: [
                                  Expanded(
                                    child: _StatBox(
                                      label: 'Quantity',
                                      value: '1 ${info.unit}',
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _StatBox(
                                      label: 'Items',
                                      value: '${info.size}',
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _StatBox(
                                      label: 'Avg Score',
                                      value: '--',
                                      isHighlight: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Description
                              Text(
                                info.description,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.slate600,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Offline access section
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.slate50,
                            border: Border(
                              top: BorderSide(color: AppColors.slate100),
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.surface,
                                  boxShadow: AppShadows.sm,
                                ),
                                child: const Icon(
                                  Symbols.cloud_download,
                                  color: AppColors.slate400,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Offline Access',
                                      style: AppTypography.bodyMedium.copyWith(
                                        color: AppColors.text,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Download pack (12MB)',
                                      style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.slate400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Toggle placeholder
                              Container(
                                width: 44,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppColors.slate200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: AppColors.surface,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Game modes section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Game Mode',
                        style: AppTypography.h4.copyWith(
                          color: AppColors.text,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blue50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '3 MODES',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildGameModeCard(
                    context,
                    () => startGameCallback(GameMode.simple),
                    'Simple Mode',
                    '5 rounds solo game • Quick play',
                    Symbols.person,
                    AppColors.primary,
                    AppColors.blue100,
                  ),
                  const SizedBox(height: 12),
                  _buildGameModeCard(
                    context,
                    () => _showChallengeDialog(
                      context,
                      (gameId) => startGameCallback(GameMode.challenge, gameId),
                    ),
                    'Challenge Friends',
                    'Get a PIN code • Play together',
                    Symbols.groups,
                    AppColors.secondary,
                    AppColors.orange100,
                  ),
                  const SizedBox(height: 12),
                  _buildGameModeCard(
                    context,
                    null, // Not implemented yet
                    'Online Match',
                    'Ranked PvP • Random opponent',
                    Symbols.public,
                    AppColors.purple600,
                    AppColors.purple100,
                    enabled: false,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stack) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          appBar: AppBar(
            title: const Text('Select Game Mode'),
            backgroundColor: AppColors.bg,
          ),
          body: Center(child: Text('Error loading collection: $error')),
        );
      },
      loading: () {
        return Scaffold(
          backgroundColor: AppColors.bg,
          appBar: AppBar(
            title: const Text('Select Game Mode'),
            backgroundColor: AppColors.bg,
          ),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  void _showChallengeDialog(
    BuildContext context,
    Function(String) startGameCallback,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          ChallengeDialog(startGameCallback: startGameCallback),
    );
  }

  Widget _buildGameModeCard(
    BuildContext context,
    GestureTapCallback? onTap,
    String title,
    String description,
    IconData icon,
    Color accentColor,
    Color bgColor, {
    bool enabled = true,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: enabled ? AppColors.surface : AppColors.slate50,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            bottom: BorderSide(
              color: enabled ? AppColors.slate200 : AppColors.slate100,
              width: 4,
            ),
            top: const BorderSide(color: AppColors.slate200),
            left: const BorderSide(color: AppColors.slate200),
            right: const BorderSide(color: AppColors.slate200),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppShadows.sm,
              ),
              child: Icon(
                icon,
                size: 28,
                color: accentColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.h4.copyWith(
                      fontSize: 18,
                      color: enabled ? AppColors.text : AppColors.slate400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTypography.bodySmall.copyWith(
                      color: enabled ? AppColors.slate500 : AppColors.slate400,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                border: Border.all(
                  color: enabled ? AppColors.slate100 : AppColors.slate200,
                  width: 2,
                ),
              ),
              child: Icon(
                enabled ? Symbols.play_arrow : Symbols.lock,
                size: 18,
                color: enabled ? AppColors.slate300 : AppColors.slate400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.label,
    required this.value,
    this.isHighlight = false,
  });

  final String label;
  final String value;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isHighlight ? AppColors.orange50 : AppColors.slate50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlight ? AppColors.orange100 : AppColors.slate100,
        ),
      ),
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.labelSmall.copyWith(
              color: isHighlight ? AppColors.orange400 : AppColors.slate400,
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTypography.h4.copyWith(
              fontSize: 18,
              color: isHighlight ? AppColors.secondary : AppColors.text,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
