import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_typography.dart';

/// Primary button with game-btn shadow effect for a "pressed button" appearance
class ActionButton extends StatefulWidget {
  const ActionButton._internal({
    required this.onPressed,
    required this.buttonColor,
    required this.shadowColor,
    this.label,
    this.icon,
    this.showArrow = false,
    this.fullWidth = false,
    super.key,
  });

  factory ActionButton.primary({
    required VoidCallback? onPressed,
    String? label,
    IconData? icon,
    bool showArrow = false,
    bool fullWidth = false,
    Key? key,
  }) {
    return ActionButton._internal(
      onPressed: onPressed,
      label: label,
      icon: icon,
      showArrow: showArrow,
      fullWidth: fullWidth,
      key: key,
      buttonColor: AppColors.primary600,
      shadowColor: AppColors.primary800,
    );
  }

  factory ActionButton.secondary({
    required VoidCallback? onPressed,
    String? label,
    IconData? icon,
    bool showArrow = false,
    bool fullWidth = false,
    Key? key,
  }) {
    return ActionButton._internal(
      onPressed: onPressed,
      label: label,
      icon: icon,
      showArrow: showArrow,
      fullWidth: fullWidth,
      key: key,
      buttonColor: AppColors.accent600,
      shadowColor: AppColors.accent800,
    );
  }

  final VoidCallback? onPressed;
  final String? label;
  final Color buttonColor;
  final Color shadowColor;
  final IconData? icon;
  final bool showArrow;
  final bool fullWidth;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;

    final shadow = [
      BoxShadow(color: widget.shadowColor, offset: const Offset(0, 6)),
    ];
    final pressedShadow = [BoxShadow(color: widget.shadowColor)];

    return GestureDetector(
      onTapDown: isDisabled ? null : (_) => setState(() => _isPressed = true),
      onTapUp: isDisabled ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: isDisabled ? null : () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isDisabled
              ? AppColors.neutral300
              : (_isPressed ? widget.shadowColor : widget.buttonColor),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isPressed ? pressedShadow : shadow,
        ),
        transform: Matrix4.translationValues(0, _isPressed ? 6 : 0, 0),
        child: Row(
          mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, color: Colors.white, size: 20, weight: 800),
              if (widget.label != null || widget.showArrow)
                const SizedBox(width: 8),
            ],
            if (widget.label != null) ...[
              Text(widget.label!, style: AppTypography.buttonLarge),
              if (widget.showArrow) const SizedBox(width: 8),
            ],
            if (widget.showArrow) ...[
              const Icon(
                Symbols.arrow_forward,
                color: Colors.white,
                size: 20,
                weight: 800,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
