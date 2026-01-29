import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../client/talker.dart';
import '../../../../router/routes.dart';
import '../../../design_system/components/appbar.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_typography.dart';
import '../../../design_system/components/buttons/icon_buttons.dart';
import 'local/select_collection.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      appBar: AppBar(
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
                    color: AppColors.neutral200,
                    border: Border.all(color: AppColors.neutral50, width: 2),
                  ),
                  child: const Icon(
                    Symbols.person,
                    color: AppColors.neutral400,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Action buttons
          Row(
            children: [
              RoundedIconButton(
                icon: Symbols.help,
                onPressed: () => const OnboardingRoute().go(context),
                size: 40,
                iconColor: AppColors.primary600,
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
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
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
                      const Positioned(
                        top: -4,
                        left: -24,
                        child: Icon(
                          Symbols.eco,
                          size: 48,
                          color: AppColors.primary300,
                        ),
                      ),
                      const Positioned(
                        bottom: -8,
                        right: -24,
                        child: Icon(
                          Symbols.bolt,
                          size: 40,
                          color: AppColors.accent300,
                        ),
                      ),
                      // Title
                      Column(
                        children: [
                          const Text('Quoscient', style: AppTypography.h1),
                          const SizedBox(height: 8),
                          Text(
                            'Train your intuition',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.neutral500,
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
                        color: AppColors.accent600,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Collections',
                        style: AppTypography.h4.copyWith(
                          color: AppColors.neutral900,
                        ),
                      ),
                    ],
                  ),
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
