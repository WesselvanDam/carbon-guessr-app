// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

import '../src/design_system/styles/app_colors.dart';

abstract final class AppTheme {
  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.neutral50,
  );
}
