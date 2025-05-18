import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/collection/collection_info.dart';
import '../../models/collection/collection_item.dart';
import '../../models/collection/source.dart';
import '../../services/collection/collection_repository.dart';
import '../../services/collection/collection_service.dart';

part 'collection_providers.g.dart';

/// The GitHub repository URL where the data is stored
const String _githubBaseUrl =
    'https://raw.githubusercontent.com/WesselvanDam/carbon-guessr-app/refs/heads/main';

/// Provider for the currently selected collection name
@riverpod
String currentCollection(Ref ref) {
  // Default to 'carbon' collection if not specified otherwise
  return 'carbon';
}

/// A notifier provider that allows changing the current collection
@riverpod
class CurrentCollectionNotifier extends _$CurrentCollectionNotifier {
  @override
  String build() {
    // Default to 'carbon' collection
    return 'carbon';
  }

  /// Switch to a different collection
  void setCollection(String collectionName) {
    state = collectionName;
  }
}

/// Provider for the CollectionService
@riverpod
CollectionService collectionService(Ref ref) {
  final collectionName = ref.watch(currentCollectionProvider);

  final service = CollectionService(
    baseUrl: _githubBaseUrl,
    collectionName: collectionName,
  );

  ref.onDispose(() {
    service.dispose();
  });

  return service;
}

/// Provider for the CollectionRepository
@riverpod
CollectionRepository collectionRepository(Ref ref) {
  final service = ref.watch(collectionServiceProvider);
  return CollectionRepository(service);
}

/// Provider for the collection info
@riverpod
Future<CollectionInfo> collectionInfo(Ref ref) {
  // Will automatically update when collection changes
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getInfo();
}

/// Provider for a specific collection item by ID
@riverpod
Future<CollectionItem> collectionItem(Ref ref, int id) {
  // Will automatically update when collection changes
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getItem(id);
}

/// Provider for all collection items
@riverpod
Future<List<CollectionItem>> allCollectionItems(Ref ref) {
  // Will automatically update when collection changes
  final repository = ref.watch(collectionRepositoryProvider);

  // In a real application, you might want to get item IDs from the collection info
  // or fetch them separately
  final allIds = List<int>.generate(10, (index) => index + 1);

  return repository.getAllItems(allIds);
}

/// Provider for specific collection items by IDs
@riverpod
Future<List<CollectionItem>> collectionItemsByIds(Ref ref, List<int> ids) {
  // Will automatically update when collection changes
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getAllItems(ids);
}

/// Provider for sources of a specific collection item
@riverpod
Future<List<Source>> collectionItemSources(Ref ref, int itemId) async {
  // Will automatically update when collection changes
  final repository = ref.watch(collectionRepositoryProvider);
  final item = await repository.getItem(itemId);
  return repository.getAllSources(item.sources);
}

/// Provider for a localized collection item
@riverpod
Future<CollectionItem> localizedCollectionItem(Ref ref, int id, String locale) {
  // Will automatically update when collection changes
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getLocalizedItem(id, locale);
}

/// Provider for all localized collection items
@riverpod
Future<List<CollectionItem>> allLocalizedCollectionItems(
    Ref ref, String locale) {
  // Will automatically update when collection changes
  final repository = ref.watch(collectionRepositoryProvider);

  // In a real application, you might want to get item IDs from the collection info
  // or fetch them separately
  final allIds = List<int>.generate(10, (index) => index + 1);

  return repository.getAllLocalizedItems(allIds, locale);
}
