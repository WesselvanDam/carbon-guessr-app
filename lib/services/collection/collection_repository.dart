import '../../models/collection/collection_info.dart';
import '../../models/collection/collection_item.dart';
import '../../models/collection/localization_data.dart';
import '../../models/collection/source.dart';
import '../../services/collection/collection_service.dart';

/// Repository for handling collection data operations
class CollectionRepository {
  CollectionRepository(this._service);
  final CollectionService _service;

  /// Fetches the info data for the collection
  Future<CollectionInfo> getInfo() => _service.fetchInfo();

  /// Fetches a collection item by ID
  Future<CollectionItem> getItem(int id) => _service.fetchItem(id);

  /// Fetches all collection items for the given IDs
  Future<List<CollectionItem>> getAllItems(List<int> ids) =>
      _service.fetchAllItems(ids);

  /// Fetches a source by ID
  Future<Source> getSource(int id) => _service.fetchSource(id);

  /// Fetches all sources for the given IDs
  Future<List<Source>> getAllSources(List<int> ids) =>
      _service.fetchAllSources(ids);

  /// Fetches a localized data item by ID and locale
  Future<LocalizationData> getLocalizationData(int id, String locale) =>
      _service.fetchLocalizationData(id, locale);

  /// Fetches all localized data items for the given IDs and locale
  Future<List<LocalizationData>> getAllLocalizationData(
          List<int> ids, String locale) =>
      _service.fetchAllLocalizationData(ids, locale);

  /// Gets a collection item with localized text
  Future<CollectionItem> getLocalizedItem(int id, String locale) async {
    // Fetch both the base data and the localized data
    final item = await _service.fetchItem(id);
    final localizedData = await _service.fetchLocalizationData(id, locale);

    // Return a new CollectionItem with the localized title and description
    return CollectionItem(
      id: item.id,
      title: localizedData.title,
      description: localizedData.description,
      value: item.value,
      category: item.category,
      sources: item.sources,
    );
  }

  /// Gets all collection items with localized text
  Future<List<CollectionItem>> getAllLocalizedItems(
      List<int> ids, String locale) async {
    final futures = ids.map((id) => getLocalizedItem(id, locale));
    return await Future.wait(futures);
  }

  /// Gets all sources for a given collection item
  Future<List<Source>> getSourcesForItem(CollectionItem item) =>
      getAllSources(item.sources);
}
