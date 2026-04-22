import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../client/talker.dart';
import '../../../../router/routes.dart';
import '../../../design_system/components/appbar.dart';
import '../../../design_system/components/buttons/icon_buttons.dart';
import '../../../design_system/components/snackbar/snackbar_presenter.dart';
import '../../../design_system/styles/app_colors.dart';
import '../../../design_system/styles/app_typography.dart';
import '../../../shared/widgets/logo.dart';
import '../../forms/models/feedback_form_kind.dart';
import '../../forms/pages/form_page.dart';
import 'local/help_dialog.dart';
import 'local/select_collection.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Future<void> _openHelpDialog(BuildContext context) async {
    final destination = await HelpDialog.show(context);
    if (destination == null || !context.mounted) {
      return;
    }

    switch (destination) {
      case HelpDestination.tutorial:
        const OnboardingRoute().go(context);
      case HelpDestination.website:
        await _launchExternal(
          context,
          url: 'https://quoscient.app',
          errorMessage: 'Could not open the website right now.',
        );
      case HelpDestination.feedback:
        await FormPage.showSheet(context, formKind: FeedbackFormKind.general);
      case HelpDestination.email:
        await _launchExternal(
          context,
          url: 'mailto:info@quoscient.app',
          errorMessage: 'Could not open your email app right now.',
        );
    }
  }

  Future<void> _launchExternal(
    BuildContext context, {
    required String url,
    required String errorMessage,
  }) async {
    try {
      final didLaunch = await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );

      if (didLaunch || !context.mounted) {
        return;
      }
    } catch (_) {
      if (!context.mounted) {
        return;
      }
    }

    AppSnackbarPresenter.showError(context, message: errorMessage);
  }

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
                onPressed: () => _openHelpDialog(context),
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
