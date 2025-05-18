import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/collection/collection_providers.dart';

part 'collection_data_manager.g.dart';

/// Key for storing the current collection in SharedPreferences
const String _currentCollectionKey = 'current_collection';

/// A utility class to manage collection data loading and caching
@riverpod
class CollectionDataManager extends _$CollectionDataManager {
  @override
  Future<void> build() async {
    // Load the saved collection on initialization
    _loadSavedCollection();

    // Listen for collection changes to update cache
    ref.listen(currentCollectionNotifierProvider, (previous, current) {
      if (previous != current) {
        // Clear cache and preload data for the new collection
        _onCollectionChanged(current);
      }
    });

    return;
  }

  /// Load the saved collection from SharedPreferences
  Future<void> _loadSavedCollection() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedCollection = prefs.getString(_currentCollectionKey);

      if (savedCollection != null) {
        // Update the current collection in the provider
        ref
            .read(currentCollectionNotifierProvider.notifier)
            .setCollection(savedCollection);
        debugPrint('Loaded saved collection: $savedCollection');
      }
    } catch (e) {
      debugPrint('Error loading saved collection: $e');
    }
  }

  /// Handle collection change
  Future<void> _onCollectionChanged(String newCollection) async {
    try {
      // Save the new collection to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_currentCollectionKey, newCollection);
      debugPrint('Saved new collection: $newCollection');

      // Preload data for the new collection
      await preloadAllData();
    } catch (e) {
      debugPrint('Error handling collection change: $e');
    }
  }

  /// Preloads all collection data and caches it
  Future<void> preloadAllData() async {
    // Get ref to all data providers
    final allDataFuture = ref.read(allCollectionItemsProvider.future);
    final infoFuture = ref.read(collectionInfoProvider.future);

    // Fetch in parallel
    await Future.wait([
      allDataFuture,
      infoFuture,
    ]);

    // Log success
    debugPrint('All collection data preloaded successfully');
  }

  /// Preloads data for a specific collection item
  Future<void> preloadItemData(int id) async {
    final itemFuture = ref.read(collectionItemProvider(id).future);
    final sourcesFuture = ref.read(collectionItemSourcesProvider(id).future);

    await Future.wait([
      itemFuture,
      sourcesFuture,
    ]);

    debugPrint('Item data for ID: $id preloaded successfully');
  }

  /// Preloads localized data for a specific collection item
  Future<void> preloadLocalizedItemData(int id, String locale) async {
    final localizedItemFuture =
        ref.read(localizedCollectionItemProvider(id, locale).future);

    await localizedItemFuture;
    debugPrint(
        'Localized item data for ID: $id, locale: $locale preloaded successfully');
  }
}
