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
    required String id,
    required GameMode mode,
    required List<GameRound> rounds,
    required int currentRoundIndex,
    @Default(false) bool isCompleted,
  }) = _GameSession;

  factory GameSession.fromJson(Map<String, dynamic> json) =>
      _$GameSessionFromJson(json);
}
