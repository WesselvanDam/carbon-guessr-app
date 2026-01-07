import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design system shadows matching the Tailwind-based UI designs
class AppShadows {
  AppShadows._();

  // Button shadows - provides a "pressed button" effect
  static const List<BoxShadow> gameBtn = [
    BoxShadow(
      color: AppColors.primaryDark,
      offset: Offset(0, 6),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> gameBtnActive = [
    BoxShadow(
      color: AppColors.primaryDark,
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> gameBtnSecondary = [
    BoxShadow(
      color: AppColors.secondaryDark,
      offset: Offset(0, 6),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> gameBtnSecondaryActive = [
    BoxShadow(
      color: AppColors.secondaryDark,
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  // Card shadows
  static const List<BoxShadow> gameCard = [
    BoxShadow(
      color: Color(0x0D000000), // rgba(0, 0, 0, 0.05)
      offset: Offset(0, 8),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0D000000), // rgba(0, 0, 0, 0.05)
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x08000000), // rgba(0, 0, 0, 0.03)
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x262563EB), // rgba(37, 99, 235, 0.15)
      offset: Offset(0, 10),
      blurRadius: 40,
      spreadRadius: -10,
    ),
  ];

  // Inner shadows (for inset effects)
  static const List<BoxShadow> innerLg = [
    BoxShadow(
      color: Color(0x0F000000), // rgba(0, 0, 0, 0.06)
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> innerLight = [
    BoxShadow(
      color: Color(0x4DFFFFFF), // rgba(255, 255, 255, 0.3)
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  // Standard Material-like shadows
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x1A000000), // rgba(0, 0, 0, 0.1)
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x1A000000), // rgba(0, 0, 0, 0.1)
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
  ];
}
