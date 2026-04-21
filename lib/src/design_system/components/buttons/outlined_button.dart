import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_typography.dart';

/// Pressable outlined button that matches the app's border-depth style.
class OutlinedActionButton extends StatefulWidget {
  const OutlinedActionButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.backgroundColor = AppColors.white,
    this.borderColor = AppColors.neutral200,
    this.textColor = AppColors.neutral700,
    this.borderWidth = 4,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool fullWidth;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;

  @override
  State<OutlinedActionButton> createState() => _OutlinedActionButtonState();
}

class _OutlinedActionButtonState extends State<OutlinedActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;
    final borderColor = isDisabled ? AppColors.neutral200 : widget.borderColor;

    return GestureDetector(
      onTapDown: isDisabled ? null : (_) => setState(() => _isPressed = true),
      onTapUp: isDisabled ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: isDisabled ? null : () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isDisabled
              ? AppColors.neutral100
              : (_isPressed ? AppColors.neutral100 : widget.backgroundColor),
          borderRadius: BorderRadius.circular(16),
          border: Border(
            top: BorderSide(color: borderColor, width: 2),
            left: BorderSide(color: borderColor, width: 2),
            right: BorderSide(color: borderColor, width: 2),
            bottom: BorderSide(
              color: borderColor,
              width: (_isPressed || isDisabled) ? 2 : widget.borderWidth,
            ),
          ),
        ),
        transform: Matrix4.translationValues(
          0,
          (_isPressed || isDisabled) ? widget.borderWidth - 2 : 0,
          0,
        ),
        child: Row(
          mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                color: isDisabled ? AppColors.neutral400 : widget.textColor,
                size: 20,
                weight: 800,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: AppTypography.buttonMedium.copyWith(
                color: isDisabled ? AppColors.neutral400 : widget.textColor,
                fontVariations: const [FontVariation('wght', 800)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
