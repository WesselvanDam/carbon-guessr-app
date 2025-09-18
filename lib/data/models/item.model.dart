import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.model.freezed.dart';
part 'item.model.g.dart';

/// Model representing an individual item from a collection
@freezed
abstract class ItemModel with _$ItemModel {
  const factory ItemModel({
    required int id,
    required String title,
    required String quantity,
    required String description,
    required double value,
    required String category,
    required List<int> sources,
    @Default(true) bool isItemA,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}
