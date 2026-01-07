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

  Future<List<ItemModel>> getItems(List<int> ids) async {
    await future;
    final items = state.value!.values
        .where((item) => ids.contains(item.id))
        .toList();
    final remainingIds = ids
        .where((id) => !items.any((item) => item.id == id))
        .toList();

    if (remainingIds.isNotEmpty) {
      final fetchedItems = await _fetchItems(remainingIds);
      items.addAll(fetchedItems);
    }

    items.sort((a, b) => ids.indexOf(a.id) - ids.indexOf(b.id));
    return items;
  }

  Future<AsyncValue<String>> storeRemainingItems() async {
    await future;
    final currentItemIds =
        state.value?.keys.map((id) => int.parse(id)).toList() ?? [];

    return _fetchItems(currentItemIds, exclude: true)
        .then<AsyncValue<String>>(
          (value) => const AsyncData('Stored the remaining items'),
        )
        .catchError((error) {
          talker.error('Error storing remaining items: $error');
          return AsyncError<String>(error.toString(), StackTrace.current);
        });
  }

  Future<List<ItemModel>> _fetchItems(
    List<int> ids, {
    bool exclude = false,
  }) async {
    final hasInternet = await ref.read(
      hasInternetConnectionProvider.selectAsync((hasInternet) => hasInternet),
    );
    if (!hasInternet) {
      talker.error('No internet connection, cannot fetch remaining items');
      throw Exception('No internet connection');
    }

    final supabase = ref.read(supabaseApiProvider(collectionId));
    final fetchedItems = await supabase.fetchItems(ids, exclude: exclude);
    talker.debug('Fetched ${fetchedItems.length} items.');
    state = AsyncValue.data({
      ...?state.value,
      ...{for (final item in fetchedItems) item.id.toString(): item},
    });
    return fetchedItems;
  }
}
