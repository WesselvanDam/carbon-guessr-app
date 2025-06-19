import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/collection/collection.model.dart';
import '../../models/collection/item.model.dart';
import '../../models/collection/source.dart';
import '../../router/router.dart';
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
Future<Map<String, CollectionModel>> collections(Ref ref) {
  final repository = ref.watch(collectionRepositoryProvider(''));
  return repository.getAllCollections();
}

/// Provider for the collection info
@riverpod
Future<CollectionModel> collection(Ref ref, String collectionId) async {
  // Try to get all collections info from the provider
  final collectionsInfoAsync = await ref.watch(collectionsProvider.future);

  // If the collection is already present, return it
  if (collectionsInfoAsync.containsKey(collectionId)) {
    return collectionsInfoAsync[collectionId]!;
  }

  // Otherwise, fetch from repository
  final repository = ref.watch(collectionRepositoryProvider(collectionId));
  return repository.getInfo();
}

@riverpod
Future<CollectionModel?> currentCollection(Ref ref) async {
  // Get the current collection ID from the router
  final collectionId = ref.watch(routerProvider.select(
    (router) => router.state.pathParameters['cid'],
  ));

  // If no collection ID is provided, return null
  if (collectionId == null || collectionId.isEmpty) {
    return null;
  }

  return ref.watch(collectionProvider(collectionId).future);
}

/// Provider for a specific collection item by ID
@riverpod
Future<ItemModel> collectionItem(Ref ref, String collectionId, int id) {
  final repository = ref.watch(collectionRepositoryProvider(collectionId));
  return repository.getItem(id);
}

/// Provider for specific collection items by IDs
@riverpod
Future<List<ItemModel>> collectionItemsByIds(
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
Future<ItemModel> localizedCollectionItem(
    Ref ref, String collectionId, int id, String locale) {
  final repository = ref.watch(collectionRepositoryProvider(collectionId));
  return repository.getLocalizedItem(id, locale);
}
