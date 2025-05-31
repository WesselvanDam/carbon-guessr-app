import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/collection/collection_info.dart';
import '../../models/collection/collection_item.dart';
import '../../models/collection/source.dart';
import '../../services/collection/collection_repository.dart';
import '../../services/collection/collection_service.dart';
import '../client/http_client.dart';

part 'collection_providers.g.dart';

/// Provider for the CollectionService
@riverpod
CollectionService collectionService(Ref ref, String collectionId) {
  final dio = ref.watch(httpClientProvider);
  final service = CollectionService(dio);

  return service;
}

/// Provider for the CollectionRepository
@riverpod
CollectionRepository collectionRepository(Ref ref, String collectionId) {
  final service = ref.watch(collectionServiceProvider(collectionId));
  return CollectionRepository(service, collectionId);
}

@Riverpod(keepAlive: true)
Future<List<CollectionInfo>> collectionsInfo(Ref ref) {
  final repository = ref.watch(collectionRepositoryProvider(''));
  return repository.getAllCollections();
}

/// Provider for the collection info
@riverpod
Future<CollectionInfo> collectionInfo(Ref ref, String collectionId) {
  final repository = ref.watch(collectionRepositoryProvider(collectionId));
  return repository.getInfo();
}

/// Provider for a specific collection item by ID
@riverpod
Future<CollectionItem> collectionItem(Ref ref, String collectionId, int id) {
  final repository = ref.watch(collectionRepositoryProvider(collectionId));
  return repository.getItem(id);
}

/// Provider for specific collection items by IDs
@riverpod
Future<List<CollectionItem>> collectionItemsByIds(
    Ref ref, String collectionId, List<int> ids) {
  final repository = ref.watch(collectionRepositoryProvider(collectionId));
  return repository.getItems(ids);
}

/// Provider for sources of a specific collection item
@riverpod
Future<List<Source>> collectionItemSources(
    Ref ref, String collectionId, int itemId) async {
  final repository = ref.watch(collectionRepositoryProvider(collectionId));
  final item = await repository.getItem(itemId);
  return repository.getAllSources(item.sources);
}

/// Provider for a localized collection item
@riverpod
Future<CollectionItem> localizedCollectionItem(
    Ref ref, String collectionId, int id, String locale) {
  final repository = ref.watch(collectionRepositoryProvider(collectionId));
  return repository.getLocalizedItem(id, locale);
}
