import 'dart:math';

import 'package:flutter/material.dart';

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
    required double ratioBoundary,
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
      ratioBoundary: ratioBoundary,
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

  /// Calculates a score for a player's estimated ratio compared to a ground truth ratio.
  ///
  /// Args:
  ///   - estimate: The player's estimated ratio.
  ///   - groundTruth: The actual ground truth ratio.
  ///   - minRatio: The smallest possible ratio (e.g., a/b, where a <= b).
  ///             This value must be positive and <= 1.
  ///   - perfectScoreC: The score awarded for a perfect match (default is 100).
  ///
  /// Returns:
  ///   - The calculated score, between 0 and perfectScoreC.
  ///
  /// Throws:
  ///   - ArgumentError: If estimate, groundTruth, or minRatio are not positive,
  ///                  or if minRatio > 1.
  double calculateRoundScore(
    double truth,
    double estimate,
    double ratioBoundary, {
    double maxScore = 100.0,
  }) {
    debugPrint('Ratio Boundary: $ratioBoundary, Estimate: $estimate, Truth: $truth');
    if (estimate <= 0 || truth <= 0 || ratioBoundary <= 0) {
      throw ArgumentError('Ratios (estimate, groundTruth, minRatio) must be positive.');
    }
    if (ratioBoundary > 1) {
      throw ArgumentError('minRatio cannot be greater than 1. It represents a/b where a <= b.');
    }

    // Handle the special case where the only possible ratio is 1
    if (ratioBoundary == 1.0) {
      // If groundTruth is not 1, it's outside the allowed [min_r, max_r] = [1,1]
      // We proceed by definition of minRatio=1.
      // Logically, if minRatio=1, groundTruth must be 1.
      return estimate == truth ? maxScore : 0.0;
    }

    // Transform to log space
    final double logEst = log(estimate);
    final double logGt = log(truth);
    final double logMinR = log(ratioBoundary);

    // Calculate logarithmic error
    final double errorLog = (logEst - logGt).abs();

    // If estimate perfectly matches groundTruth, errorLog is 0
    if (errorLog == 0) return maxScore;

    // Calculate the maximum logarithmic span that defines the 0-score boundary.
    // maxRatio = 1/minRatio
    // maxLogSpan = log(maxRatio) - log(minRatio) = -log(minRatio) - log(minRatio) = -2 * log(minRatio)
    // This value is positive because minRatio < 1, so log(minRatio) < 0.
    final double maxLogSpan = -2 * logMinR;

    if (maxLogSpan == 0) {
      // Should be covered by minRatio == 1 case, but for robustness
      return errorLog == 0 ? maxScore : 0.0;
    }

    // Scale the score
    final double score = maxScore * exp(-10 * (errorLog / maxLogSpan));

    // Clamp score at 0
    return max(0.0, score);
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
    final score = calculateRoundScore(currentRound.correctRatio, estimate, session.ratioBoundary);

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
