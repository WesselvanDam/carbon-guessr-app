import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/models/collection.model.dart';
import '../../../../router/router.dart';
import '../../home/providers/collections.dart';

part 'current_collection.g.dart';


@riverpod
Future<CollectionModel> currentCollection(Ref ref) async {
  // Get the current collection ID from the router
  final collectionId = ref.watch(
    routerProvider.select((router) => router.state.pathParameters['cid']),
  );

  // If no collection ID is provided, return null
  if (collectionId == null || collectionId.isEmpty) {
    throw Exception('No collection ID provided in the route');
  }

  return ref.watch(collectionsProvider.selectAsync(
    (collections) {
      if (!collections.containsKey(collectionId)) {
        throw Exception('Collection with ID $collectionId not found');
      }
      return collections[collectionId]!;
    },
  ));
}
