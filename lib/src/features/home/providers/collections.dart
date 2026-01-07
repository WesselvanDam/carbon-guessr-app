import 'dart:convert';

import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../client/connectivity.dart';
import '../../../../client/local_db.dart';
import '../../../../client/talker.dart';
import '../../../../data/api/supabase_api.dart';
import '../../../../data/json.dart';
import '../../../../data/models/collection.model.dart';
import '../../../../local_storage/local_storage_repository.dart';

part 'collections.g.dart';

@Riverpod(keepAlive: true)
@JsonPersist()
class Collections extends _$Collections {
  @override
  FutureOr<Map<String, CollectionModel>> build() async {
    await persist(
      ref.watch(localDbClientProvider.future),
      key: 'collections',
      options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),
      encode: jsonEncode,
      decode: (String encoded) {
        final decoded = jsonDecode(encoded) as Json;
        return decoded.map(
          (key, value) =>
              MapEntry(key, CollectionModel.fromJson(value! as Json)),
        );
      },
    ).future;

    if (state.value != null && state.value!.isNotEmpty) {
      state = AsyncData(state.value!);
    }

    final updates = await _fetchRemoteCollections();
    return updates.isEmpty ? state.value ?? {} : {...updates};
  }

  Future<void> refresh() async {
    final updatedCollections = await _fetchRemoteCollections();
    if (updatedCollections.isEmpty) {
      talker.debug('No updated collections fetched');
      return;
    }
    state = AsyncValue.data({...?state.value, ...updatedCollections});
  }

  Future<Map<String, CollectionModel>> _fetchRemoteCollections() async {
    final hasInternet = await ref.read(
      hasInternetConnectionProvider.selectAsync((hasInternet) => hasInternet),
    );
    if (!hasInternet) {
      talker.debug('No internet connection, skipping remote collections fetch');
      return {};
    }

    final lastCollectionFetchTime = ref
        .read(localStorageRepositoryProvider)
        .getInt(.lastCollectionFetchTime);
    final supabase = ref.read(supabaseApiProvider(null));
    final updatedCollections = await supabase.fetchUpdatedCollections(
      lastCollectionFetchTime,
    );

    talker.debug(
      'Fetched ${updatedCollections.length} collections updated since ${DateTime.fromMillisecondsSinceEpoch(lastCollectionFetchTime ?? 0, isUtc: true).toIso8601String()}',
    );

    final currentCollections = state.value ?? {};
    for (final updated in updatedCollections.values) {
      final current = currentCollections[updated.id];
      if (current != null && current.isSaved) {
        // Collections saved locally are not updated automatically
        talker.debug(
          'Collection ${updated.id} is saved locally, updating lastUpdated only.',
        );
        currentCollections[updated.id] = current.copyWith(
          lastUpdated: updated.lastUpdated,
        );
      } else {
        // Collections not saved locally are updated fully
        talker.debug('Updating collection ${updated.id} from remote.');
        currentCollections[updated.id] = updated;
        clearOutdatedCache(updated);
      }
    }

    ref
        .read(localStorageRepositoryProvider)
        .setInt(
          .lastCollectionFetchTime,
          DateTime.now().toUtc().millisecondsSinceEpoch,
        );
    return currentCollections;
  }

  Future<void> clearOutdatedCache(CollectionModel outdatedCollections) async {
    talker.debug('Clearing cache for collection: ${outdatedCollections.id}');
    ref.read(
      localDbClientProvider.selectAsync((db) {
        db.delete('${outdatedCollections.id}-items');
        db.delete('${outdatedCollections.id}-sources');
      }),
    );
  }
}
