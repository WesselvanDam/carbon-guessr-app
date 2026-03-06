import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../client/talker.dart';
import '../../../../router/routes.dart';
import '../../../design_system/components/appbar.dart';
import '../../../design_system/components/buttons/icon_buttons.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_typography.dart';
import '../../../shared/widgets/logo.dart';
import 'local/select_collection.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      appBar: AppBar(
        children: [
          const SizedBox.square(dimension: 32, child: Logo()),
          Text(
            'Quoscient',
            style: AppTypography.h2.copyWith(
              fontVariations: [const FontVariation('wght', 900)],
            ),
          ),
          const Spacer(),
          // Action buttons
          Row(
            spacing: 8,
            children: [
              RoundedIconButton(
                icon: Symbols.help,
                onPressed: () => const OnboardingRoute().go(context),
                size: 40,
                iconColor: AppColors.primary600,
              ),
              if (kDebugMode)
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
