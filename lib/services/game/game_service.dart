import 'dart:math';
import 'package:flutter/foundation.dart';

import '../../models/collection/collection_info.dart';
import '../../models/collection/collection_item.dart';
import '../../models/game/game_round.dart';
import '../../models/game/game_session.dart';
import '../../models/game/item_pair.dart';

/// Service responsible for game logic and calculations
class GameService {
  /// Generates item IDs needed for a game session
  List<int> generateRequiredItemIds({
    required CollectionInfo collectionInfo,
    required int numberOfRounds,
    String? sessionId,
  }) {
    // Ensure we have enough items in the collection
    if (collectionInfo.size < 2) {
      throw Exception('Not enough items in the collection to create a game session');
    }
    
    // Create a session ID if not provided
    final id = sessionId ?? DateTime.now().millisecondsSinceEpoch.toString();
    
    // Generate item IDs based on the session ID
    return _generateDeterministicItemIds(
      sessionId: id,
      collectionSize: collectionInfo.size,
      count: numberOfRounds * 2,
    );
  }

  /// Creates a new game session with the given mode, collection info, and items
  GameSession createGameSession({
    required GameMode mode,
    required List<CollectionItem> items,
    required int numberOfRounds,
    String? sessionId,
  }) {
    // Ensure we have enough items
    if (items.length < numberOfRounds * 2) {
      throw Exception('Not enough items provided to create a game session');
    }

    // Create a unique ID for the session
    final id = sessionId ?? DateTime.now().millisecondsSinceEpoch.toString();
    
    // Create the rounds
    final rounds = List.generate(numberOfRounds, (index) {
      // Use deterministic selection based on index (2 items per round)
      final itemA = items[index * 2];
      final itemB = items[index * 2 + 1];
      
      final pair = ItemPair(itemA: itemA, itemB: itemB);

      // Calculate the correct ratio
      final correctRatio = pair.itemA.value / pair.itemB.value;

      return GameRound(
        roundNumber: index + 1,
        itemPair: pair,
        correctRatio: correctRatio,
      );
    });

    return GameSession(
      id: id,
      mode: mode,
      rounds: rounds,
      currentRoundIndex: 0,
    );
  }

  /// Generates deterministic random item IDs based on the session ID
  List<int> _generateDeterministicItemIds({
    required String sessionId,
    required int collectionSize,
    required int count,
  }) {
    if (count > collectionSize) {
      throw Exception('Requested more items than available in the collection');
    }

    // Create a deterministic random generator using the session ID as seed
    final seedValue = sessionId.hashCode;
    final random = Random(seedValue);

    // Generate unique item IDs (1-based index as per requirement)
    final Set<int> uniqueIds = {};

    while (uniqueIds.length < count) {
      // Generate random IDs from 1 to collectionSize (inclusive)
      final id = random.nextInt(collectionSize) + 1;
      uniqueIds.add(id);
    }

    return uniqueIds.toList();
  }

  /// Calculates the score for a single round based on user estimate
  double calculateRoundScore(double correctRatio, double userEstimate) {
    try {
      // Handle edge cases
      if (correctRatio <= 0) {
        return 0; // Avoid division by zero
      }

      // Calculate accuracy percentage as described in the technical requirements
      // AccuracyPercentage = 100 - (abs(CorrectRatio - PlayerEstimate) / CorrectRatio) * 100
      final accuracy =
          100 - (((correctRatio - userEstimate).abs() / correctRatio) * 100);

      // Ensure score is between 0 and 100
      return accuracy.clamp(0.0, 100.0);
    } catch (e) {
      debugPrint('Error calculating score: $e');
      return 0;
    }
  }

  /// Completes a round with the user's estimate
  GameSession submitRoundEstimate({
    required GameSession session,
    required double userEstimate,
  }) {
    if (session.isCompleted ||
        session.currentRoundIndex >= session.rounds.length) {
      throw Exception('Cannot submit estimate for completed session');
    }

    // Get the current round
    final currentRound = session.rounds[session.currentRoundIndex];

    // Calculate score
    final score = calculateRoundScore(currentRound.correctRatio, userEstimate);

    // Update the round with user's estimate and score
    final updatedRound = currentRound.copyWith(
      userEstimate: userEstimate,
      score: score,
      isCompleted: true,
    );

    // Create new list of rounds with the updated round
    final updatedRounds = List<GameRound>.from(session.rounds);
    updatedRounds[session.currentRoundIndex] = updatedRound;

    // Check if this was the last round
    final isLastRound = session.currentRoundIndex == session.rounds.length - 1;

    // Update the session
    return session.copyWith(
      rounds: updatedRounds,
      currentRoundIndex: isLastRound
          ? session.currentRoundIndex
          : session.currentRoundIndex + 1,
      isCompleted: isLastRound,
    );
  }

  /// Calculates the total score for a game session
  double calculateTotalScore(GameSession session) {
    double total = 0;
    int completedRounds = 0;

    for (final round in session.rounds) {
      if (round.isCompleted && round.score != null) {
        total += round.score!;
        completedRounds++;
      }
    }
    return completedRounds > 0 ? total : 0;
  }
}
