import 'dart:convert';

import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../client/connectivity.dart';
import '../../../../client/local_db.dart';
import '../../../../client/talker.dart';
import '../../../../data/api/supabase_api.dart';
import '../../../../data/json.dart';
import '../../../../data/models/item.model.dart';

part 'items.g.dart';

@Riverpod(keepAlive: true)
@JsonPersist()
class Items extends _$Items {
  @override
  FutureOr<Map<String, ItemModel>> build(String collectionId) async {
    await persist(
      ref.watch(localDbClientProvider.future),
      key: '$collectionId-items',
      options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),
      encode: jsonEncode,
      decode: (String encoded) {
        final decoded = jsonDecode(encoded) as Json;
        return decoded.map(
          (key, value) => MapEntry(key, ItemModel.fromJson(value! as Json)),
        );
      },
    ).future;

    if (state.value != null && state.value!.isNotEmpty) {
      state = AsyncData(state.value!);
    }

    return state.value ?? {};
  }

  Future<List<ItemModel>> getItemsByIds(List<int> ids) async {
    talker.debug('Getting items by IDs: $ids');
    await future;
    talker.debug('Persisted items loaded, checking for missing items.');
    final persistedItems = state.value!.values
        .where((item) => ids.contains(item.id))
        .toList();
    final remainingIds = ids
        .where((id) => !persistedItems.any((item) => item.id == id))
        .toList();
    talker.debug(
      'Fetched ${persistedItems.length} persisted items, '
      '${remainingIds.length} remaining to fetch from remote.',
    );
    final List<ItemModel> items = [...persistedItems];

    if (remainingIds.isNotEmpty) {
      final hasInternet = await ref.read(
        hasInternetConnectionProvider.selectAsync((hasInternet) => hasInternet),
      );
      if (!hasInternet) {
        talker.error('No internet connection, cannot fetch remaining items');
        throw Exception('No internet connection');
      }
      final supabase = ref.read(supabaseApiProvider(collectionId));
      final fetchedItems = await supabase.fetchItems(remainingIds);
      items.addAll(fetchedItems);
      state = AsyncValue.data({
        ...?state.value,
        ...{for (final item in fetchedItems) item.id.toString(): item},
      });
    }

    items.sort((a, b) => ids.indexOf(a.id) - ids.indexOf(b.id));
    return items;
  }
}
