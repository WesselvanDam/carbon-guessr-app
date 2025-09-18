import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection.model.freezed.dart';
part 'collection.model.g.dart';

/// Model representing general information about a collection
@freezed
abstract class CollectionModel with _$CollectionModel {
  const factory CollectionModel({
    required String id,
    required String title,
    required String tagline,
    required String description,
    required String quantity,
    required String unit,
    required int size,
    @Default(1) double ratioBoundary,
  }) = _CollectionModel;

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);
}
