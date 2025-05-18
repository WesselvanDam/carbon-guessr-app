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
