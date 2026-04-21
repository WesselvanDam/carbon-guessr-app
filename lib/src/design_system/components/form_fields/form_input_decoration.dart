import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_typography.dart';

InputDecoration buildFormInputDecoration({required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.neutral400),
    errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.error600),
    filled: true,
    fillColor: AppColors.neutral50,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.neutral200, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.neutral200, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.primary600, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.error400, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.error600, width: 2),
    ),
  );
}
