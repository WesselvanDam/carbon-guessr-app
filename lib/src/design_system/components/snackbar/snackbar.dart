import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_shadows.dart';
import '../../styles/app_typography.dart';

class AppSnackbar extends StatelessWidget {
  const AppSnackbar._internal({
    required this.message,
    required this.backgroundColor,
    required this.borderColor,
    required this.foregroundColor,
    required this.icon,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  factory AppSnackbar.success({
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Key? key,
  }) {
    return AppSnackbar._internal(
      key: key,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      backgroundColor: AppColors.success50,
      borderColor: AppColors.success200,
      foregroundColor: AppColors.success900,
      icon: Symbols.check_circle,
    );
  }

  factory AppSnackbar.error({
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Key? key,
  }) {
    return AppSnackbar._internal(
      key: key,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      backgroundColor: AppColors.error50,
      borderColor: AppColors.error200,
      foregroundColor: AppColors.error900,
      icon: Symbols.error,
    );
  }

  factory AppSnackbar.warning({
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Key? key,
  }) {
    return AppSnackbar._internal(
      key: key,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      backgroundColor: AppColors.warning50,
      borderColor: AppColors.warning200,
      foregroundColor: AppColors.warning900,
      icon: Symbols.warning,
    );
  }

  factory AppSnackbar.neutral({
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Key? key,
  }) {
    return AppSnackbar._internal(
      key: key,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
      backgroundColor: AppColors.neutral50,
      borderColor: AppColors.neutral200,
      foregroundColor: AppColors.neutral900,
      icon: Symbols.info,
    );
  }

  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color backgroundColor;
  final Color borderColor;
  final Color foregroundColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final showAction = actionLabel != null && onAction != null;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: AppShadows.md,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: foregroundColor, size: 20, weight: 700),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppTypography.bodyMedium.copyWith(
                  color: foregroundColor,
                ),
              ),
            ),
            if (showAction) ...[
              const SizedBox(width: 10),
              _ActionLabel(
                label: actionLabel!,
                color: foregroundColor,
                onTap: onAction!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActionLabel extends StatelessWidget {
  const _ActionLabel({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(color: color),
        ),
      ),
    );
  }
}
