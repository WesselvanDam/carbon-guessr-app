import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/item.model.dart';

part 'round.model.freezed.dart';
part 'round.model.g.dart';

/// Represents a single round in the game
@freezed
abstract class RoundModel with _$RoundModel {
  const factory RoundModel({
    required int roundNumber,
    required ItemModel itemA,
    required ItemModel itemB,
    required double correctRatio,
    double? userEstimate,
    @Default(0) int score,
    @Default(false) bool isCompleted,
  }) = _RoundModel;

  factory RoundModel.fromJson(Map<String, dynamic> json) =>
      _$RoundModelFromJson(json);
}
