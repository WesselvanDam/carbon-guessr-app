import 'package:freezed_annotation/freezed_annotation.dart';

import '../collection/collection_item.dart';

part 'item_pair.freezed.dart';
part 'item_pair.g.dart';

/// Represents a pair of items displayed during a game round
@freezed
abstract class ItemPair with _$ItemPair {
  const factory ItemPair({
    required CollectionItem itemA,
    required CollectionItem itemB,
  }) = _ItemPair;

  factory ItemPair.fromJson(Map<String, dynamic> json) =>
      _$ItemPairFromJson(json);
}
