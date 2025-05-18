import 'package:freezed_annotation/freezed_annotation.dart';

import 'item_pair.dart';

part 'game_round.freezed.dart';
part 'game_round.g.dart';

/// Represents a single round in the game
@freezed
abstract class GameRound with _$GameRound {
  const factory GameRound({
    required int roundNumber,
    required ItemPair itemPair,
    required double correctRatio,
    double? userEstimate,
    double? score,
    @Default(false) bool isCompleted,
  }) = _GameRound;

  factory GameRound.fromJson(Map<String, dynamic> json) =>
      _$GameRoundFromJson(json);
}
