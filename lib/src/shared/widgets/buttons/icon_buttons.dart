import 'package:flutter/material.dart';
import '../../design_system/app_colors.dart';

/// Rounded icon button with white background and border
class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 48,
    this.iconSize = 24,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.label,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size / 4),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.surface,
          borderRadius: BorderRadius.circular(size / 4),
          border: Border.all(
            color: borderColor ?? AppColors.slate200,
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor ?? AppColors.slate400,
        ),
      ),
    );
  }
}

/// Square icon button with pressed effect
class SquareIconButton extends StatefulWidget {
  const SquareIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 48,
    this.iconSize = 24,
    this.borderRadius = 16,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.borderWidth = 4,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final double borderWidth;

  @override
  State<SquareIconButton> createState() => _SquareIconButtonState();
}

class _SquareIconButtonState extends State<SquareIconButton> {
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
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.surface,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border(
            bottom: BorderSide(
              color: widget.borderColor ?? AppColors.slate200,
              width: _isPressed ? 0 : widget.borderWidth,
            ),
            top: BorderSide(
              color: widget.borderColor ?? AppColors.slate200,
              width: 1,
            ),
            left: BorderSide(
              color: widget.borderColor ?? AppColors.slate200,
              width: 1,
            ),
            right: BorderSide(
              color: widget.borderColor ?? AppColors.slate200,
              width: 1,
            ),
          ),
        ),
        transform: Matrix4.translationValues(0, _isPressed ? widget.borderWidth : 0, 0),
        child: Icon(
          widget.icon,
          size: widget.iconSize,
          color: widget.iconColor ?? AppColors.slate400,
        ),
      ),
    );
  }
}
