import 'package:freezed_annotation/freezed_annotation.dart';

part 'localization_data.freezed.dart';
part 'localization_data.g.dart';

/// Model representing localized text for a collection item
@freezed
abstract class LocalizationData with _$LocalizationData {
  const factory LocalizationData({
    required int id,
    required String title,
    required String description,
  }) = _LocalizationData;

  factory LocalizationData.fromJson(Map<String, dynamic> json) =>
      _$LocalizationDataFromJson(json);
}
