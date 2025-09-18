import 'local_storage_api.dart';
import 'local_storage_keys.dart';

class LocalStorageRepository {
  LocalStorageRepository(this._api);

  final LocalStorageApi _api;


  /// Saves a boolean value to local storage using the enum key.
  Future<void> saveBool(LocalStorageBoolKeys key, bool value) async {
    await _api.saveBool(key.name, value);
  }

  Future<void> setBool(LocalStorageBoolKeys key, bool value) async {
    await _api.setBool(key.name, value);
  }

  bool? getBool(LocalStorageBoolKeys key) {
    return _api.getBool(key.name);
  }

  Future<void> setString(LocalStorageStringKeys key, String value) async {
    await _api.setString(key.name, value);
  }

  String? getString(LocalStorageStringKeys key) {
    return _api.getString(key.name);
  }

  Future<void> setDouble(LocalStorageDoubleKeys key, double value) async {
    await _api.setDouble(key.name, value);
  }

  double? getDouble(LocalStorageDoubleKeys key) {
    return _api.getDouble(key.name);
  }

  Future<void> setInt(LocalStorageIntKeys key, int value) async {
    await _api.setInt(key.name, value);
  }

  int? getInt(LocalStorageIntKeys key) {
    return _api.getInt(key.name);
  }

  Future<void> setStringList(
      LocalStorageStringListKeys key, List<String> value) async {
    await _api.setStringList(key.name, value);
  }

  List<String>? getStringList(LocalStorageStringListKeys key) {
    return _api.getStringList(key.name);
  }
}
