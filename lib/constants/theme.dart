// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade the package to version 8.2.0.
///
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class AppTheme {
  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = FlexThemeData.light(
    // User defined custom colors made with FlexSchemeColor() API.
    colors: const FlexSchemeColor(
      primary: Color(0xFF004A78),
      secondary: Color(0xFF84B9EF),
      tertiary: Color(0xFFEFBA84),
      error: Color(0xFFBA1A1A),
    ),
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      inputDecoratorIsFilled: false,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // ColorScheme seed generation configuration for light mode.
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      useError: true,
    ),
    tones: FlexSchemeVariant.jolly.tones(Brightness.light),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    fontFamily: 'Roboto',
  );
}


class MaterialTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff745086),
      surfaceTint: Color(0xff745086),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfff6d9ff),
      onPrimaryContainer: Color(0xff2c0b3e),
      secondary: Color(0xff68596d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff0dcf4),
      onSecondaryContainer: Color(0xff231728),
      tertiary: Color(0xff815252),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdad9),
      onTertiaryContainer: Color(0xff331112),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffff7fc),
      onSurface: Color(0xff1e1a1f),
      onSurfaceVariant: Color(0xff4b444d),
      outline: Color(0xff7d747e),
      outlineVariant: Color(0xffcec3ce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff342f35),
      inversePrimary: Color(0xffe2b7f4),
      primaryFixed: Color(0xfff6d9ff),
      onPrimaryFixed: Color(0xff2c0b3e),
      primaryFixedDim: Color(0xffe2b7f4),
      onPrimaryFixedVariant: Color(0xff5b396d),
      secondaryFixed: Color(0xfff0dcf4),
      onSecondaryFixed: Color(0xff231728),
      secondaryFixedDim: Color(0xffd3c0d8),
      onSecondaryFixedVariant: Color(0xff504255),
      tertiaryFixed: Color(0xffffdad9),
      onTertiaryFixed: Color(0xff331112),
      tertiaryFixedDim: Color(0xfff5b7b7),
      onTertiaryFixedVariant: Color(0xff663b3b),
      surfaceDim: Color(0xffe0d7df),
      surfaceBright: Color(0xfffff7fc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffaf1f8),
      surfaceContainer: Color(0xfff5ebf3),
      surfaceContainerHigh: Color(0xffefe5ed),
      surfaceContainerHighest: Color(0xffe9e0e7),
    ),
  );
}
