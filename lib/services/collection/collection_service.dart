import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/collection/collection_info.dart';
import '../../models/collection/collection_item.dart';
import '../../models/collection/localization_data.dart';
import '../../models/collection/source.dart';

/// Exception thrown when fetching collection data fails
class CollectionFetchException implements Exception {
  CollectionFetchException(this.message, [this.error]);
  final String message;
  final dynamic error;

  @override
  String toString() =>
      'CollectionFetchException: $message${error != null ? ', $error' : ''}';
}

/// Service for fetching collection data from the API
class CollectionService {
  CollectionService({
    required this.baseUrl,
    required this.collectionName,
    http.Client? client,
  }) : _client = client ?? http.Client();
  final String baseUrl;
  final String collectionName;
  final http.Client _client;

  /// The base URL for the collection dataset
  String get collectionUrl => '$baseUrl/data/api/$collectionName';

  /// Fetches the info data for the collection
  Future<CollectionInfo> fetchInfo() async {
    try {
      debugPrint("""URI: $collectionUrl/info.json""");
      final response = await _client.get(Uri.parse('$collectionUrl/info.json'));

      if (response.statusCode == 200) {
        return CollectionInfo.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw CollectionFetchException(
          'Failed to fetch info: HTTP status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw CollectionFetchException('Failed to fetch info', e);
    }
  }

  /// Fetches a collection item by ID
  Future<CollectionItem> fetchItem(int id) async {
    try {
      debugPrint("""URI: $collectionUrl/data/$id.json""");
      final response =
          await _client.get(Uri.parse('$collectionUrl/data/$id.json'));

      if (response.statusCode == 200) {
        return CollectionItem.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw CollectionFetchException(
          'Failed to fetch item with ID $id: HTTP status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw CollectionFetchException('Failed to fetch item with ID $id', e);
    }
  }

  /// Fetches all collection items
  ///
  /// Note: This requires knowledge of how many items exist; in a real-world
  /// scenario, you might want to fetch a list of available IDs first.
  Future<List<CollectionItem>> fetchAllItems(List<int> ids) async {
    try {
      final futures = ids.map(fetchItem);
      return await Future.wait(futures);
    } catch (e) {
      throw CollectionFetchException('Failed to fetch all items', e);
    }
  }

  /// Fetches a source by ID
  Future<Source> fetchSource(int id) async {
    try {
      final response =
          await _client.get(Uri.parse('$collectionUrl/sources/$id.json'));

      if (response.statusCode == 200) {
        return Source.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw CollectionFetchException(
          'Failed to fetch source with ID $id: HTTP status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw CollectionFetchException('Failed to fetch source with ID $id', e);
    }
  }

  /// Fetches all sources
  Future<List<Source>> fetchAllSources(List<int> ids) async {
    try {
      final futures = ids.map(fetchSource);
      return await Future.wait(futures);
    } catch (e) {
      throw CollectionFetchException('Failed to fetch all sources', e);
    }
  }

  /// Fetches a localized data item by ID and locale
  Future<LocalizationData> fetchLocalizationData(int id, String locale) async {
    try {
      final response =
          await _client.get(Uri.parse('$collectionUrl/l10n/$locale/$id.json'));

      if (response.statusCode == 200) {
        return LocalizationData.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw CollectionFetchException(
          'Failed to fetch localization data with ID $id for locale $locale: HTTP status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw CollectionFetchException(
          'Failed to fetch localization data with ID $id for locale $locale',
          e);
    }
  }

  /// Fetches all localized data items for a specific locale
  Future<List<LocalizationData>> fetchAllLocalizationData(
      List<int> ids, String locale) async {
    try {
      final futures = ids.map((id) => fetchLocalizationData(id, locale));
      return await Future.wait(futures);
    } catch (e) {
      throw CollectionFetchException(
          'Failed to fetch all localization data for locale $locale', e);
    }
  }

  /// Closes the HTTP client
  void dispose() {
    _client.close();
  }
}
