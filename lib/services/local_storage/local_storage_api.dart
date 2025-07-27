import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageApi {
  LocalStorageApi(this._prefs);

  final SharedPreferencesWithCache _prefs;

  /// Saves a boolean value to local storage
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  /// sets a string value to local storage
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  /// Retrieves a string value from local storage
  String? getString(String key) {
    return _prefs.getString(key);
  }

  /// sets a boolean value to local storage
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  /// Retrieves a boolean value from local storage
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  /// sets a double value to local storage
  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  /// Retrieves a double value from local storage
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  /// sets an int value to local storage
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  /// Retrieves an int value from local storage
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// sets a list of strings to local storage
  Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  /// Retrieves a list of strings from local storage
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  /// Removes a value from local storage
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}
