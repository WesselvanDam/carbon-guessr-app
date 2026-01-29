import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../constants/game_mode.dart';
import '../../../../router/routes.dart';
import '../../../design_system/components/appbar.dart';
import '../../../design_system/components/chips/info_chip.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_shadows.dart';
import '../../../design_system/styles/app_typography.dart';
import '../../../shared/utils/extensions.dart';
import '../../../design_system/components/buttons/icon_buttons.dart';
import '../../game/providers/items.dart';
import '../../game/repository/game_repository.dart';
import '../../home/providers/collections.dart';
import '../providers/current_collection.dart';
import 'challenge_dialog.dart';

class CollectionPage extends ConsumerWidget {
  const CollectionPage({required this.cid, super.key});

  final String cid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(currentCollectionProvider);

    return collection.when(
      skipLoadingOnReload: true,
      data: (info) {
        void startGameCallback(GameMode mode, [String? gameId]) => GameRoute(
          cid: info.id,
          gid: gameId ?? GameRepository.newGameId,
          mode: mode,
        ).go(context);

        return Scaffold(
          backgroundColor: AppColors.neutral50,
          appBar: AppBar(
            children: [
              SquareIconButton(
                icon: Symbols.arrow_back,
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: AppColors.white,
                iconColor: AppColors.neutral400,
                borderColor: AppColors.neutral200,
              ),
              const Expanded(
                child: Text(
                  'COLLECTION',
                  style: AppTypography.captionLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Collection info card
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.neutral100),
                      boxShadow: AppShadows.gameCard,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadiusGeometry.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top accent bar
                          const ColoredBox(
                            color: AppColors.primary600,
                            child: SizedBox(height: 8, width: double.infinity),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title and icon
                                Text(
                                  info.title.toTitleCase(),
                                  style: AppTypography.h3.copyWith(
                                    color: AppColors.neutral900,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                InfoChip.primary(
                                  label: info.quantity.toUpperCase(),
                                ),
                                const SizedBox(height: 16),
                                // Stats row
                                Row(
                                  children: [
                                    Expanded(
                                      child: _StatBox(
                                        label: 'Unit',
                                        value: info.unit,
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
                                    const Expanded(
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
                                MarkdownBody(
                                  onTapLink: (text, href, title) => href != null
                                      ? launchUrlString(
                                          href,
                                          mode: LaunchMode.externalApplication,
                                        )
                                      : null,
                                  data: info.description,
                                  styleSheet: MarkdownStyleSheet(
                                    p: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.neutral600,
                                      height: 1.6,
                                    ),
                                    a: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.primary700,
                                      fontVariations: const [
                                        FontVariation('wght', 900),
                                      ],
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Offline access section
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.neutral50,
                              border: Border(
                                left: BorderSide(color: AppColors.neutral100),
                                right: BorderSide(color: AppColors.neutral100),
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
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
                                    color: AppColors.white,
                                    boxShadow: AppShadows.sm,
                                  ),
                                  child: const Icon(
                                    Symbols.cloud_download,
                                    fill: 1,
                                    color: AppColors.neutral400,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Offline Access',
                                        style: AppTypography.bodyMedium
                                            .copyWith(
                                              color: AppColors.neutral900,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      Text(
                                        'Download pack to play without internet.',
                                        style: AppTypography.bodySmall.copyWith(
                                          color: AppColors.neutral400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: info.isSaved,
                                  activeThumbColor: AppColors.primary600,
                                  activeTrackColor: AppColors.primary100,
                                  inactiveThumbColor: AppColors.neutral300,
                                  inactiveTrackColor: AppColors.neutral200,
                                  trackOutlineColor:
                                      const WidgetStateProperty.fromMap({
                                        WidgetState.selected:
                                            AppColors.primary100,
                                        WidgetState.any: AppColors.neutral300,
                                      }),
                                  onChanged: (value) => value
                                      ? ref
                                            .read(collectionsProvider.notifier)
                                            .storeCollection(info.id)
                                      : ref
                                            .read(collectionsProvider.notifier)
                                            .unStoreCollection(info.id),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                          color: AppColors.neutral900,
                        ),
                      ),
                      InfoChip.neutral(label: '2 MODES'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildGameModeCard(
                    context,
                    () => startGameCallback(GameMode.simple),
                    'Simple Mode',
                    '5 rounds solo game • Quick play',
                    Symbols.person,
                    AppColors.primary600,
                    AppColors.primary100,
                  ),
                  const SizedBox(height: 12),
                  _buildGameModeCard(
                    context,
                    () => _showChallengeDialog(
                      context,
                      (gameId) => startGameCallback(GameMode.challenge, gameId),
                    ),
                    'Challenge Friends',
                    'Get a PIN code • Play the same rounds',
                    Symbols.groups,
                    AppColors.accent600,
                    AppColors.accent100,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stack) {
        return Scaffold(
          backgroundColor: AppColors.neutral50,
          body: Center(child: Text('Error loading collection: $error')),
        );
      },
      loading: () {
        return const Scaffold(
          backgroundColor: AppColors.neutral50,
          body: Center(child: CircularProgressIndicator()),
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
          color: enabled ? AppColors.white : AppColors.neutral50,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            bottom: BorderSide(
              color: AppColors.neutral200,
              width: enabled ? 4 : 1,
            ),
            top: const BorderSide(color: AppColors.neutral200),
            left: const BorderSide(color: AppColors.neutral200),
            right: const BorderSide(color: AppColors.neutral200),
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
              child: Icon(icon, size: 28, color: accentColor, fill: 1),
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
                      color: enabled
                          ? AppColors.neutral900
                          : AppColors.neutral400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: AppTypography.bodySmall.copyWith(
                      color: enabled
                          ? AppColors.neutral500
                          : AppColors.neutral400,
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
                color: AppColors.neutral50,
                border: Border.all(
                  color: enabled ? AppColors.neutral200 : AppColors.neutral100,
                  width: 2,
                ),
              ),
              child: Icon(
                enabled ? Symbols.play_arrow : Symbols.lock,
                size: 18,
                color: enabled ? AppColors.neutral400 : AppColors.neutral300,
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
        color: isHighlight ? AppColors.accent50 : AppColors.neutral50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlight ? AppColors.accent100 : AppColors.neutral100,
        ),
      ),
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.labelSmall.copyWith(
              color: isHighlight ? AppColors.accent500 : AppColors.neutral500,
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTypography.h4.copyWith(
              fontSize: 18,
              color: isHighlight ? AppColors.accent600 : AppColors.neutral900,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
