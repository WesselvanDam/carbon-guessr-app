import 'package:flutter/material.dart' hide Dialog;
import 'package:material_symbols_icons/symbols.dart';

import '../../../../design_system/components/buttons/icon_buttons.dart';
import '../../../../design_system/components/dialogs/dialog.dart';
import '../../../../design_system/styles/app_colors.dart';
import '../../../../design_system/styles/app_shadows.dart';
import '../../../../design_system/styles/app_typography.dart';

enum HelpDestination { tutorial, website, feedback, email }

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  static Future<HelpDestination?> show(BuildContext context) {
    return showDialog<HelpDestination>(
      context: context,
      barrierColor: AppColors.neutral950.withValues(alpha: 0.62),
      builder: (_) => const HelpDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
            decoration: const BoxDecoration(
              color: AppColors.neutral50,
              border: Border(bottom: BorderSide(color: AppColors.neutral100)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary100),
                    boxShadow: AppShadows.sm,
                  ),
                  child: const Icon(
                    Symbols.help,
                    size: 22,
                    color: AppColors.primary700,
                    fill: 1,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Quoscient Support',
                    style: AppTypography.h4.copyWith(
                      color: AppColors.primary700,
                    ),
                  ),
                ),
                RoundedIconButton(
                  size: 32,
                  icon: Symbols.close,
                  backgroundColor: AppColors.neutral50,
                  borderColor: AppColors.neutral200,
                  iconColor: AppColors.neutral500,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                _HelpActionTile(
                  icon: Symbols.rebase_edit,
                  iconColor: AppColors.accent600,
                  title: 'Tutorial',
                  subtitle: 'Learn the game mechanics',
                  onTap: () =>
                      Navigator.of(context).pop(HelpDestination.tutorial),
                ),
                _HelpActionTile(
                  icon: Symbols.public,
                  iconColor: AppColors.primary600,
                  title: 'Website',
                  subtitle: 'Visit our official site',
                  onTap: () =>
                      Navigator.of(context).pop(HelpDestination.website),
                ),
                _HelpActionTile(
                  icon: Symbols.rate_review,
                  iconColor: AppColors.accent600,
                  title: 'Feedback',
                  subtitle: 'Share your thoughts',
                  onTap: () =>
                      Navigator.of(context).pop(HelpDestination.feedback),
                ),
                _HelpActionTile(
                  icon: Symbols.mail,
                  iconColor: AppColors.primary600,
                  title: 'Email',
                  subtitle: 'Contact support team',
                  onTap: () => Navigator.of(context).pop(HelpDestination.email),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpActionTile extends StatelessWidget {
  const _HelpActionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.neutral100),
          boxShadow: AppShadows.card,
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.neutral50,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(icon, color: iconColor, size: 22, fill: 1),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.neutral900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Symbols.chevron_right,
              color: AppColors.neutral400,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
