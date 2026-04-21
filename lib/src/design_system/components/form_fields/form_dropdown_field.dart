import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_shadows.dart';
import '../../styles/app_typography.dart';
import 'form_input_decoration.dart';

class FormDropdownField extends StatelessWidget {
  const FormDropdownField({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.validator,
    super.key,
  });

  final String label;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.captionSmall.copyWith(
            color: AppColors.primary700,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          key: ValueKey(value),
          initialValue: value,
          validator: validator,
          onChanged: onChanged,
          isExpanded: true,
          menuMaxHeight: 280,
          borderRadius: BorderRadius.circular(16),
          decoration: buildFormInputDecoration(
            hintText: 'Select feedback type',
          ),
          dropdownColor: AppColors.white,
          icon: const Icon(
            Symbols.keyboard_arrow_down,
            color: AppColors.neutral500,
          ),
          style: AppTypography.bodyMedium.copyWith(color: AppColors.neutral900),
          selectedItemBuilder: (context) => options
              .map(
                (option) => Text(
                  option,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.neutral900,
                  ),
                ),
              )
              .toList(),
          items: options.map((option) {
            final isSelected = option == value;

            return DropdownMenuItem(
              value: option,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary50 : AppColors.neutral50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary200
                        : AppColors.neutral100,
                  ),
                  boxShadow: isSelected ? AppShadows.sm : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        option,
                        style: AppTypography.bodyMedium.copyWith(
                          color: isSelected
                              ? AppColors.primary700
                              : AppColors.neutral900,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(
                        Symbols.check,
                        size: 18,
                        color: AppColors.primary700,
                        weight: 800,
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
