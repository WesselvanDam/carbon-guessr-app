import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../design_system/app_colors.dart';
import '../../design_system/app_shadows.dart';
import '../../design_system/app_typography.dart';

/// Secondary button with secondary color and game-btn shadow effect
class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.showArrow = false,
    this.fullWidth = false,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final bool showArrow;
  final bool fullWidth;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;

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
              ? AppColors.slate300
              : (_isPressed ? AppColors.secondaryDark : AppColors.secondary),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isPressed
              ? AppShadows.gameBtnSecondaryActive
              : AppShadows.gameBtnSecondary,
        ),
        transform: Matrix4.translationValues(0, _isPressed ? 6 : 0, 0),
        child: Row(
          mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: AppTypography.buttonLarge,
            ),
            if (widget.showArrow) ...[
              const SizedBox(width: 8),
              Icon(
                Symbols.arrow_forward,
                color: Colors.white,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
