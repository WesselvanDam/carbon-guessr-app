import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../client/http_client.dart';
import '../models/collection.model.dart';
import '../models/item.model.dart';
import '../models/localization_data.dart';
import '../models/source.dart';


part 'collection_api.g.dart';

/// Provider for the CollectionApi
@Riverpod(keepAlive: true)
CollectionApi collectionApi(Ref ref, String collectionId) {
  final dio = ref.watch(httpClientProvider);
  return CollectionApi(dio);
}

/// API for fetching collection data from the remote server
@RestApi()
abstract class CollectionApi {
  factory CollectionApi(Dio dio, {String? baseUrl}) = _CollectionApi;

  /// Fetches all available collections from the API
  @GET('/collections.json')
  Future<CollectionsResponse> fetchAllCollections();

  /// Fetches the info data for the collection
  @GET('/{collectionId}/info.json')
  Future<CollectionModel> fetchInfo(@Path() String collectionId);

  /// Fetches a collection item by ID
  @GET('/{collectionId}/data/{id}.json')
  Future<ItemModel> fetchItem(@Path() String collectionId, @Path() int id);

  /// Fetches a source by ID
  @GET('/{collectionId}/sources/{id}.json')
  Future<Source> fetchSource(@Path() String collectionId, @Path() int id);

  /// Fetches a localized data item by ID and locale
  @GET('/{collectionId}/l10n/{locale}/{id}.json')
  Future<LocalizationData> fetchLocalizationData(
      @Path() String collectionId, @Path() int id, @Path() String locale);
}

/// Response model for collections list
class CollectionsResponse {
  CollectionsResponse({required this.data});

  factory CollectionsResponse.fromJson(Map<String, dynamic> json) {
    final items = json['data'] as List<dynamic>;
    final data = {
      for (final item in items)
        // ignore: avoid_dynamic_calls
        (item['id'] as String):
            CollectionModel.fromJson(item as Map<String, dynamic>)
    };
    return CollectionsResponse(data: data);
  }

  final Map<String, CollectionModel> data;
}
