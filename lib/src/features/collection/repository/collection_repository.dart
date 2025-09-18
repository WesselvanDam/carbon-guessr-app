
import '../../../../data/api/collection_api.dart';
import '../../../../data/models/collection.model.dart';
import '../../../../data/models/item.model.dart';
import '../../../../data/models/localization_data.dart';
import '../../../../data/models/source.dart';

/// Repository for handling collection data operations
class CollectionRepository {
  CollectionRepository(this._api, this._cid);
  final CollectionApi _api;
  final String _cid;

  /// Fetches the list of all available collections
  Future<Map<String, CollectionModel>> getAllCollections() async {
    final response = await _api.fetchAllCollections();
    return response.data;
  }

  /// Fetches the info data for the collection
  Future<CollectionModel> getInfo() => _api.fetchInfo(_cid);

  /// Fetches a collection item by ID
  Future<ItemModel> getItem(int id) => _api.fetchItem(_cid, id);

  /// Fetches all collection items for the given IDs
  Future<List<ItemModel>> getItems(List<int> ids) {
    final futures = ids.map((id) => getItem(id));
    return Future.wait(futures);
  }

  /// Fetches a source by ID
  Future<Source> getSource(int id) => _api.fetchSource(_cid, id);

  /// Fetches all sources for the given IDs
  Future<List<Source>> getAllSources(List<int> ids) {
    final futures = ids.map((id) => getSource(id));
    return Future.wait(futures);
  }

  /// Fetches a localized data item by ID and locale
  Future<LocalizationData> getLocalizationData(int id, String locale) =>
      _api.fetchLocalizationData(_cid, id, locale);

  /// Fetches all localized data items for the given IDs and locale
  Future<List<LocalizationData>> getAllLocalizationDatas(
      List<int> ids, String locale) {
    final futures = ids.map((id) => getLocalizationData(id, locale));
    return Future.wait(futures);
  }

  /// Gets a collection item with localized text
  Future<ItemModel> getLocalizedItem(int id, String locale) async {
    // Fetch both the base data and the localized data
    final item = await _api.fetchItem(_cid, id);
    final l10n = await getLocalizationData(id, locale);

    // Return a new collection item with localized data
    return item.copyWith(
      title: l10n.title,
      description: l10n.description,
    );
  }
}
