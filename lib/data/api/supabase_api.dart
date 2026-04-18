import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

import '../../client/supabase.dart';
import '../../client/talker.dart';
import '../models/collection.model.dart';
import '../models/item.model.dart';
import '../models/source.dart';

part 'supabase_api.g.dart';

/// Provider for the SupabaseApi
@Riverpod(keepAlive: true)
SupabaseApi supabaseApi(Ref ref, String? collectionId) {
  final supabase = ref.watch(supabaseClientProvider);
  return SupabaseApi(supabase, collectionId);
}

/// API for fetching collection data from the remote server
class SupabaseApi {
  SupabaseApi(this._client, this._collectionId);

  final SupabaseClient _client;
  late final String? _collectionId;

  /// Fetches collections updated since the given timestamp
  Future<Map<String, CollectionModel>> fetchUpdatedCollections(
    int? lastFetchTime,
  ) async {
    var query = _client.from('collections').select().gt(
          'updated_at',
          DateTime.fromMillisecondsSinceEpoch(
            lastFetchTime ?? 0,
            isUtc: true,
          ).toIso8601String(),
        );
    if (kReleaseMode) {
      query = query.eq('published', true);
    }
    final response = await query
        .catchError((error) {
          talker.error('Error fetching updated collections: $error');
          return [];
        });

    return {
      for (final json in response)
        json['id'] as String: CollectionModel.fromJson(json),
    };
  }

  /// Fetches all collection items for the given IDs
  Future<List<ItemModel>> fetchItems(
    List<int> ids, {
    bool exclude = false,
  }) async {
    var query = _client.from('items').select().eq('collection', _collectionId!);
    // if ids is empty, we fetch all items, so no need to add an ID filter
    if (ids.isNotEmpty) {
      query = exclude
          ? query.not('id', 'in', '(${ids.join(',')})')
          : query.inFilter('id', ids);
    }
    final response = await query.catchError((error) {
      talker.error('Error fetching items: $error');
      return [];
    });

    return response.map<ItemModel>((json) => ItemModel.fromJson(json)).toList();
  }

  /// Fetches all sources for the given IDs.
  ///
  /// Sources are globally shared across all collections. The caller is
  /// responsible for passing only the IDs that are relevant to the current
  /// collection (e.g. the IDs referenced by the collection's items).
  Future<List<Source>> fetchSources(
    List<int> ids, {
    bool exclude = false,
  }) async {
    var query = _client
        .from('sources')
        .select()
        .eq('collection', _collectionId!);
    if (ids.isNotEmpty) {
      query = exclude
          ? query.not('id', 'in', '(${ids.join(',')})')
          : query.inFilter('id', ids);
    }
    final response = await query.catchError((error) {
      talker.error('Error fetching sources: $error');
      return [];
    });

    return response.map<Source>((json) => Source.fromJson(json)).toList();
  }
}
