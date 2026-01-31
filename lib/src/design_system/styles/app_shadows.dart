import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Design system shadows matching the Tailwind-based UI designs
class AppShadows {
  AppShadows._();

  // Card shadows
  // TODO: use AppColors for shadow colors where appropriate
  static const List<BoxShadow> gameCard = [
    BoxShadow(
      color: AppColors.neutral100, // rgba(0, 0, 0, 0.05)
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> card = [
    BoxShadow(
      color:  Color(0x0D000000), // rgba(0, 0, 0, 0.05)
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
    ),
  ];

  static const List<BoxShadow> innerLight = [
    BoxShadow(
      color: Color(0x4DFFFFFF), // rgba(255, 255, 255, 0.3)
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  // Standard Material-like shadows
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x1A000000), // rgba(0, 0, 0, 0.1)
      offset: Offset(0, 1),
      blurRadius: 3,
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
