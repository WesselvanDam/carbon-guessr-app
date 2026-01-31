// ignore_for_file: invalid_annotation_target

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
    @JsonKey(fromJson: _sourcesFromJson, toJson: _sourcesToJson)
    required List<int> sources,
    @Default(true) bool isItemA,
  }) = _ItemModel;
  const ItemModel._();

  String get subtitle =>
      '${category}${category.isNotEmpty ? ' · ' : ''}${quantity}';

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}

List<int> _sourcesFromJson(String sources) => sources
    .split(',')
    .map((e) => int.tryParse(e.trim()) ?? 0)
    .where((e) => e != 0)
    .toList();

String _sourcesToJson(List<int> sources) => sources.join(',');
