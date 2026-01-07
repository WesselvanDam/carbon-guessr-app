import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../client/talker.dart';
import '../../../../router/routes.dart';
import '../../../shared/design_system/app_colors.dart';
import '../../../shared/design_system/app_typography.dart';
import '../../../shared/widgets/buttons/icon_buttons.dart';
import 'local/select_collection.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.bg.withOpacity(0.9),
              border: const Border(
                bottom: BorderSide(
                  color: Color(0x80F1F5F9), // slate-100 with 50% opacity
                  width: 0.5,
                ),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // User avatar placeholder
                  GestureDetector(
                    onTap: () {
                      // TODO: User profile action
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.slate200,
                            border: Border.all(
                              color: AppColors.surface,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Symbols.person,
                            color: AppColors.slate400,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action buttons
                  Row(
                    children: [
                      RoundedIconButton(
                        icon: Symbols.help,
                        onPressed: () {
                          const OnboardingRoute().go(context);
                        },
                        size: 40,
                        iconSize: 24,
                        iconColor: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      RoundedIconButton(
                        icon: Symbols.settings,
                        onPressed: () {
                          // TODO: Settings action
                        },
                        size: 40,
                        iconSize: 24,
                      ),
                      const SizedBox(width: 8),
                      RoundedIconButton(
                        icon: Symbols.bug_report,
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TalkerScreen(talker: talker),
                          ),
                        ),
                        size: 40,
                        iconSize: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Main content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  // App title section
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // Background decorative icons
                      Positioned(
                        top: -4,
                        left: -24,
                        child: Icon(
                          Symbols.eco,
                          size: 48,
                          color: AppColors.primary.withOpacity(0.2),
                        ),
                      ),
                      Positioned(
                        bottom: -8,
                        right: -24,
                        child: Icon(
                          Symbols.bolt,
                          size: 40,
                          color: AppColors.secondary.withOpacity(0.2),
                        ),
                      ),
                      // Title
                      Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primaryDark,
                                AppColors.primary,
                              ],
                            ).createShader(bounds),
                            child: const Text(
                              'Quoscient',
                              style: AppTypography.h1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Measure your impact. Know the score.',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Collections section header
                  Row(
                    children: [
                      const Icon(
                        Symbols.category,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Collections',
                        style: AppTypography.h4.copyWith(
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Collections list
                  const CollectionSelector(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
