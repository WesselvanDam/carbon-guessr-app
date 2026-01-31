import 'package:flutter/widgets.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_typography.dart';

class InfoChip extends StatelessWidget {
  const InfoChip._internal({
    required this.label,
    required this.borderColor,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
    super.key,
  });

  factory InfoChip.neutral({required String label, IconData? icon, Key? key}) {
    return InfoChip._internal(
      icon: icon,
      label: label,
      borderColor: AppColors.neutral200,
      backgroundColor: AppColors.neutral100,
      textColor: AppColors.neutral500,
      key: key,
    );
  }

  factory InfoChip.primary({required String label, IconData? icon, Key? key}) {
    return InfoChip._internal(
      label: label,
      icon: icon,
      borderColor: AppColors.primary200,
      backgroundColor: AppColors.primary100,
      textColor: AppColors.primary500,
      key: key,
    );
  }

  factory InfoChip.accent({required String label, IconData? icon, Key? key}) {
    return InfoChip._internal(
      label: label,
      icon: icon,
      borderColor: AppColors.accent200,
      backgroundColor: AppColors.accent100,
      textColor: AppColors.accent500,
      key: key,
    );
  }

  factory InfoChip.success({required String label, IconData? icon, Key? key}) {
    return InfoChip._internal(
      label: label,
      icon: icon,
      borderColor: const Color(0xFFBBF7D0),
      backgroundColor: const Color(0xFFDCFCE7),
      textColor: const Color(0xFF15803D),
      key: key,
    );
  }

  factory InfoChip.warning({required String label, IconData? icon, Key? key}) {
    return InfoChip._internal(
      label: label,
      icon: icon,
      borderColor: const Color(0xFFFDE68A),
      backgroundColor: const Color(0xFFFFF9C4),
      textColor: const Color(0xFF92400E),
      key: key,
    );
  }

  factory InfoChip.error({required String label, IconData? icon, Key? key}) {
    return InfoChip._internal(
      label: label,
      icon: icon,
      borderColor: const Color(0xFFFCA5A5),
      backgroundColor: const Color(0xFFFFE5E5),
      textColor: const Color(0xFFB91C1C),
      key: key,
    );
  }

  final String label;
  final IconData? icon;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: icon == null ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(icon == null ? 24 : 8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: false,
            ),
            label.toUpperCase(),
            style: AppTypography.labelSmall.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
