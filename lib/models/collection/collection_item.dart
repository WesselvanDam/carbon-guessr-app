import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_item.freezed.dart';
part 'collection_item.g.dart';

/// Model representing an individual item from a collection
@freezed
abstract class CollectionItem with _$CollectionItem {
  const factory CollectionItem({
    required int id,
    required String title,
    required String description,
    required double value,
    required String category,
    required List<int> sources,
  }) = _CollectionItem;

  factory CollectionItem.fromJson(Map<String, dynamic> json) =>
      _$CollectionItemFromJson(json);
}
