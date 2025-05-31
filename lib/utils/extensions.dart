import '../models/game/game_session.dart';

/// Extensions for string manipulation
extension StringExtension on String {
  /// Capitalizes the first letter of a string
  String capitalize() {
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
    return split(' ').map((word) => word.capitalize()).join(' ');
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
