import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_typography.dart';
import 'form_input_decoration.dart';

class FormTextAreaField extends StatelessWidget {
  const FormTextAreaField({
    required this.label,
    required this.controller,
    this.validator,
    this.minLines = 4,
    this.maxLines = 8,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.captionSmall.copyWith(
            color: AppColors.accent700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: minLines,
          maxLines: maxLines,
          cursorColor: AppColors.primary600,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.neutral900),
          decoration: buildFormInputDecoration(
            hintText: 'Share your feedback...',
          ),
        ),
      ],
    );
  }
}
