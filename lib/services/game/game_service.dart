import 'dart:math';
import 'package:flutter/foundation.dart';

import '../../models/collection/collection_item.dart';
import '../../models/game/game_round.dart';
import '../../models/game/game_session.dart';
import '../../models/game/item_pair.dart';
import '../../utils/extensions.dart';

/// Service responsible for pure game logic and calculations
class GameService {
  static String get newGameId => DateTime.now()
      .millisecondsSinceEpoch
      .toString()
      .split('')
      .reversed
      .join()
      .substring(0, 8);

  /// Creates a new game session with the given mode, collection info, and items
  GameSession createGameSession({
    required List<CollectionItem> items,
    required GameMode mode,
  }) {
    // Create the rounds
    final rounds = List.generate(items.length ~/ 2, (index) {
      final itemA = items[index * 2];
      final itemB = items[index * 2 + 1];

      final pair = ItemPair(itemA: itemA, itemB: itemB);
      final correctRatio = pair.itemA.value / pair.itemB.value;

      return GameRound(
        roundNumber: index + 1,
        itemPair: pair,
        correctRatio: correctRatio,
      );
    });

    return GameSession(
      rounds: rounds,
      roundDurationSeconds: mode.roundDurationInSeconds,
    );
  }

  /// Generates deterministic random item IDs based on the session ID
  List<int> generateItemIds({
    required String gid,
    required int collectionSize,
    required int rounds,
  }) {
    if ((rounds * 2) > collectionSize) {
      throw Exception('Requested more items than available in the collection');
    }

    final seedValue = gid.hashCode;
    final random = Random(seedValue);
    final Set<int> uniqueIds = {};

    while (uniqueIds.length < (rounds * 2)) {
      final id = random.nextInt(collectionSize) + 1;
      uniqueIds.add(id);
    }

    return uniqueIds.toList();
  }

  /// Calculates the score for a single round based on user estimate
  double calculateRoundScore(double correctRatio, double userEstimate) {
    try {
      if (correctRatio <= 0) {
        return 0;
      }

      final accuracy =
          100 - (((correctRatio - userEstimate).abs() / correctRatio) * 100);

      return accuracy.clamp(0.0, 100.0);
    } catch (e) {
      debugPrint('Error calculating score: $e');
      return 0;
    }
  }

  /// Completes a round with the user's estimate
  GameSession submitEstimate({
    required GameSession session,
    required double estimate,
  }) {
    if (session.isCompleted ||
        session.currentRoundIndex >= session.rounds.length) {
      throw Exception('Cannot submit estimate for completed session');
    }

    final currentRound = session.rounds[session.currentRoundIndex];
    final score = calculateRoundScore(currentRound.correctRatio, estimate);

    final updatedRound = currentRound.copyWith(
      userEstimate: estimate,
      score: score,
    );

    final updatedRounds = List<GameRound>.from(session.rounds);
    updatedRounds[session.currentRoundIndex] = updatedRound;

    return session.copyWith(rounds: updatedRounds);
  }

  /// Moves to the next round in the session
  GameSession nextRound(GameSession session) {
    if (session.isCompleted ||
        session.currentRoundIndex > session.rounds.length - 1) {
      throw Exception('Cannot move to the next round');
    }

    final currentRound = session.rounds[session.currentRoundIndex];
    final updatedRound = currentRound.copyWith(isCompleted: true);
    final updatedRounds = List<GameRound>.from(session.rounds);
    updatedRounds[session.currentRoundIndex] = updatedRound;

    return session.copyWith(rounds: updatedRounds);
  }
}
