import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design system typography using Nunito font family
class AppTypography {
  AppTypography._();

  // Font family
  static const String fontFamily = 'Nunito';

  // Text styles
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontVariations: [
      FontVariation('wght', 900), // Black weight
    ],
    color: AppColors.neutral900,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
    fontVariations: [
      FontVariation('wght', 900), // Black weight
    ],
    color: AppColors.neutral900,
    height: 1.2,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontVariations: [
      FontVariation('wght', 800), // Extra Bold weight
    ],
    color: AppColors.neutral900,
    height: 1.3,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontVariations: [
      FontVariation('wght', 800), // Extra Bold weight
    ],
    color: AppColors.neutral900,
    height: 1.3,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontVariations: [
      FontVariation('wght', 600), // Semi-bold weight
    ],
    color: AppColors.neutral900,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontVariations: [
      FontVariation('wght', 600), // Semi-bold weight
    ],
    color: AppColors.neutral900,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontVariations: [
      FontVariation('wght', 600), // Semi-bold weight
    ],
    color: AppColors.neutral900,
    height: 1.4,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontVariations: [
      FontVariation('wght', 800), // Extra Bold
    ],
    color: AppColors.neutral900,
    height: 1.2,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontVariations: [
      FontVariation('wght', 800), // Extra Bold
    ],
    color: AppColors.neutral900,
    height: 1.2,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontVariations: [
      FontVariation('wght', 800), // Extra Bold
    ],
    color: AppColors.neutral900,
    height: 1.2,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontVariations: [
      FontVariation('wght', 700), // Bold
    ],
    color: AppColors.neutral900,
    letterSpacing: 0.8,
    height: 1.2,
  );

  static const TextStyle captionLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontVariations: [
      FontVariation('wght', 900), // Bold
    ],
    color: AppColors.neutral500,
    letterSpacing: 0.8,
    height: 1.2,
  );

  // Button text styles
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontVariations: [
      FontVariation('wght', 800), // Extra Bold
    ],
    color: AppColors.neutral50,
    height: 1.2,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontVariations: [
      FontVariation('wght', 700), // Bold
    ],
    color: AppColors.neutral50,
    height: 1.2,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontVariations: [
      FontVariation('wght', 700), // Bold
    ],
    color: AppColors.neutral50,
    height: 1.2,
  );
}
