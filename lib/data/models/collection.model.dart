import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection.model.freezed.dart';
part 'collection.model.g.dart';

/// Model representing general information about a collection
@freezed
abstract class CollectionModel with _$CollectionModel {
  const factory CollectionModel({
    required String id,
    @JsonKey(name: 'updated_at') required String lastUpdated,
    required String title,
    required String tagline,
    required String description,
    required String quantity,
    required String unit,
    required int size,
    required double ratioBoundary,
    @Default('1970-01-01T00:00:00Z') String lastFetched,
    @Default(false) bool isSaved,
  }) = _CollectionModel;
  const CollectionModel._();

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);

  /// Checks if the collection has an update available since it was last fetched.
  bool get hasUpdate =>
      DateTime.parse(lastUpdated).isAfter(DateTime.parse(lastFetched));
}
