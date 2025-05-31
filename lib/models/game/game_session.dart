import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_round.dart';

part 'game_session.freezed.dart';
part 'game_session.g.dart';

/// Enum representing the available game modes
enum GameMode {
  simple,
  research,
}

/// Represents a full game session containing multiple rounds
@freezed
abstract class GameSession with _$GameSession {
  const factory GameSession({
    required List<GameRound> rounds,
    required int roundDurationSeconds,
  }) = _GameSession;
  const GameSession._();

  factory GameSession.fromJson(Map<String, dynamic> json) =>
      _$GameSessionFromJson(json);

  int get currentRoundIndex => rounds.indexWhere((round) => !round.isCompleted);

  bool get isCompleted => rounds.every((round) => round.isCompleted);

  num get totalScore {
    return rounds.fold(0, (total, round) => total + (round.score ?? 0));
  }
}
