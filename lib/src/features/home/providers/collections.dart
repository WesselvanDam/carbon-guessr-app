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
    talker.debug('Fetched ${updates.length} updated collections.');
    return updates.isEmpty ? state.value ?? {} : {...?state.value, ...updates};
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
    final supabase = ref.read(supabaseApiProvider(''));
    final remoteCollections = await supabase.fetchUpdatedCollections(
      lastCollectionFetchTime,
    );

    ref
        .read(localStorageRepositoryProvider)
        .setInt(
          .lastCollectionFetchTime,
          DateTime.now().millisecondsSinceEpoch,
        );
    return remoteCollections;
  }
}
