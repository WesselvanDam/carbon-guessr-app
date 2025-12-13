import 'dart:convert';

import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../client/connectivity.dart';
import '../../../../client/local_db.dart';
import '../../../../client/talker.dart';
import '../../../../data/api/supabase_api.dart';
import '../../../../data/json.dart';
import '../../../../data/models/source.dart';

part 'sources.g.dart';

@Riverpod(keepAlive: true)
@JsonPersist()
class Sources extends _$Sources {
  @override
  FutureOr<Map<String, Source>> build(String collectionId) async {
    await persist(
      ref.watch(localDbClientProvider.future),
      key: '$collectionId-sources',
      options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),
      encode: jsonEncode,
      decode: (String encoded) {
        final decoded = jsonDecode(encoded) as Json;
        return decoded.map(
          (key, value) => MapEntry(key, Source.fromJson(value! as Json)),
        );
      },
    ).future;

    if (state.value != null && state.value!.isNotEmpty) {
      state = AsyncData(state.value!);
    }

    return state.value ?? {};
  }

  Future<List<Source>> getSourcesByIds(List<int> ids) async {
    talker.debug('Getting sources by IDs: $ids');
    await future;
    talker.debug('Persisted sources loaded, checking for missing sources.');
    final persistedSources = state.value!.values
        .where((source) => ids.contains(source.id))
        .toList();
    final remainingIds = ids
        .where((id) => !persistedSources.any((source) => source.id == id))
        .toList();
    talker.debug(
      'Fetched ${persistedSources.length} persisted sources, '
      '${remainingIds.length} remaining to fetch from remote.',
    );
    final List<Source> sources = [...persistedSources];

    if (remainingIds.isNotEmpty) {
      final hasInternet = await ref.read(
        hasInternetConnectionProvider.selectAsync((hasInternet) => hasInternet),
      );
      if (!hasInternet) {
        talker.error('No internet connection, cannot fetch remaining items');
        throw Exception('No internet connection');
      }
      final supabase = ref.read(supabaseApiProvider(collectionId));
      final fetchedSources = await supabase.fetchSources(remainingIds);
      sources.addAll(fetchedSources);
      state = AsyncValue.data({
        ...?state.value,
        ...{for (final source in fetchedSources) source.id.toString(): source},
      });
    }

    sources.sort((a, b) => ids.indexOf(a.id) - ids.indexOf(b.id));
    return sources;
  }
}
