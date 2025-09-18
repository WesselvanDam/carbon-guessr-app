import 'package:freezed_annotation/freezed_annotation.dart';

import 'round.model.dart';

part 'game.model.freezed.dart';
part 'game.model.g.dart';



/// Represents a full game session containing multiple rounds
@freezed
abstract class GameModel with _$GameModel {
  const factory GameModel({
    required List<RoundModel> rounds,
  }) = _GameModel;
  const GameModel._();

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  RoundModel get currentRound => rounds.firstWhere(
        (round) => !round.isCompleted,
        orElse: () => rounds.last,
      );

  int get currentRoundIndex => rounds.indexWhere((round) => !round.isCompleted);

  bool get isCompleted => rounds.every((round) => round.isCompleted);

  int get totalScore {
    return rounds.fold(0, (total, round) => total + round.score);
  }
}
