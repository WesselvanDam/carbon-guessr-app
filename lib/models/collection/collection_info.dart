import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_info.freezed.dart';
part 'collection_info.g.dart';

/// Model representing general information about a collection
@freezed
abstract class CollectionInfo with _$CollectionInfo {
  const factory CollectionInfo({
    required String id,
    required String title,
    required String description,
    required String quantity,
    required String unit,
    required int size,
  }) = _CollectionInfo;

  factory CollectionInfo.fromJson(Map<String, dynamic> json) =>
      _$CollectionInfoFromJson(json);
}
