import 'package:flutter/material.dart';

import '../models/game/game_session.dart';

/// Extensions for string manipulation
extension StringExtension on String {
  /// Capitalizes the first letter of a string
  String toSentenceCase() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Converts a string to title case (capitalizes each word)
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }
    return split(' ').map((word) => word.toSentenceCase()).join(' ');
  }
}

/// Duration per game mode
extension GameModeDuration on GameMode {
  /// Returns the duration in seconds for the game mode
  int get roundDurationInSeconds {
    return switch (this) {
      GameMode.simple => 30,
      GameMode.research => 180,
    };
  }
}

/// Readable ratio extension
extension ReadableRatio on double {
  /// Converts a ratio to a human-readable format
  TextSpan ratioToReadableTextSpan({
    required TextStyle style,
    required TextStyle leftDigitStyle,
    required TextStyle rightDigitStyle,
  }) {
    if (isNaN || isInfinite) {
      return TextSpan(
        style: style,
        children: [
          TextSpan(text: '0', style: leftDigitStyle),
          const TextSpan(text: ' : '),
          TextSpan(text: '0', style: rightDigitStyle),
        ],
      );
    }
    final String left = this < 1 ? '1' : toStringAsFixed(2);
    final String right = this <= 1 ? (1 / this).toStringAsFixed(2) : '1';
    return TextSpan(
      style: style,
      children: [
        TextSpan(text: left, style: leftDigitStyle),
        const TextSpan(text: ' : '),
        TextSpan(text: right, style: rightDigitStyle),
      ],
    );
  }

  String ratioToReadableString() {
    if (isNaN || isInfinite) {
      return '0 : 0';
    }
    final String left = this < 1 ? '1' : toStringAsFixed(2);
    final String right = this <= 1 ? (1 / this).toStringAsFixed(2) : '1';
    return '$left : $right';
  }
}
