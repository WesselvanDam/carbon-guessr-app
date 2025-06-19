import '../../models/collection/collection.model.dart';
import '../../models/collection/item.model.dart';
import '../../models/collection/localization_data.dart';
import '../../models/collection/source.dart';
import 'collection_service.dart';

/// Repository for handling collection data operations
class CollectionRepository {
  CollectionRepository(this._service, this._collectionId);
  final CollectionService _service;
  final String _collectionId;

  /// Fetches the list of all available collections
  Future<Map<String, CollectionModel>> getAllCollections() async {
    final response = await _service.fetchAllCollections();
    return response.data;
  }

  /// Fetches the info data for the collection
  Future<CollectionModel> getInfo() => _service.fetchInfo(_collectionId);

  /// Fetches a collection item by ID
  Future<ItemModel> getItem(int id) => _service.fetchItem(_collectionId, id);

  /// Fetches all collection items for the given IDs
  Future<List<ItemModel>> getItems(List<int> ids) {
    final futures = ids.map((id) => getItem(id));
    return Future.wait(futures);
  }

  /// Fetches a source by ID
  Future<Source> getSource(int id) => _service.fetchSource(_collectionId, id);

  /// Fetches all sources for the given IDs
  Future<List<Source>> getAllSources(List<int> ids) {
    final futures = ids.map((id) => getSource(id));
    return Future.wait(futures);
  }

  /// Fetches a localized data item by ID and locale
  Future<LocalizationData> getLocalizationData(int id, String locale) =>
      _service.fetchLocalizationData(_collectionId, id, locale);

  /// Fetches all localized data items for the given IDs and locale
  Future<List<LocalizationData>> getAllLocalizationDatas(
      List<int> ids, String locale) {
    final futures = ids.map((id) => getLocalizationData(id, locale));
    return Future.wait(futures);
  }

  /// Gets a collection item with localized text
  Future<ItemModel> getLocalizedItem(int id, String locale) async {
    // Fetch both the base data and the localized data
    final item = await _service.fetchItem(_collectionId, id);
    final l10n = await getLocalizationData(id, locale);

    // Return a new collection item with localized data
    return item.copyWith(
      title: l10n.title,
      description: l10n.description,
    );
  }
}
