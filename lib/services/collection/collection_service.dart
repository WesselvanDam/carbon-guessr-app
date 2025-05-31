import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/collection/collection_info.dart';
import '../../models/collection/collection_item.dart';
import '../../models/collection/localization_data.dart';
import '../../models/collection/source.dart';

part 'collection_service.g.dart';

/// Service for fetching collection data from the API
@RestApi()
abstract class CollectionService {
  factory CollectionService(Dio dio, {String? baseUrl}) = _CollectionService;

  /// Fetches all available collections from the API
  @GET('/collections.json')
  Future<CollectionsResponse> fetchAllCollections();

  /// Fetches the info data for the collection
  @GET('/{collectionId}/info.json')
  Future<CollectionInfo> fetchInfo(@Path() String collectionId);

  /// Fetches a collection item by ID
  @GET('/{collectionId}/data/{id}.json')
  Future<CollectionItem> fetchItem(@Path() String collectionId, @Path() int id);

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
    return CollectionsResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => CollectionInfo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
  final List<CollectionInfo> data;
}
