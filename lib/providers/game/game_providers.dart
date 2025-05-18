import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/game/game_round.dart';
import '../../models/game/game_session.dart';
import '../../services/game/game_service.dart';
import '../collection/collection_providers.dart';

part 'game_providers.g.dart';

/// Provider for the GameService
@riverpod
GameService gameService(Ref ref) {
  return GameService();
}

/// Provider for the active game session
@riverpod
class GameSessionNotifier extends _$GameSessionNotifier {
  @override
  GameSession? build() {
    // No active session by default
    return null;
  }

  /// Creates a new game session
  Future<void> createNewSession(GameMode mode) async {
    final gameService = ref.read(gameServiceProvider);

    // 1. Get the collection info to know the size of the collection
    final collectionInfo = await ref.read(collectionInfoProvider.future);

    // Number of rounds as specified in requirements
    const numberOfRounds = 5;

    // 2. Generate the required item IDs based on collection size
    final itemIds = gameService.generateRequiredItemIds(
      collectionInfo: collectionInfo,
      numberOfRounds: numberOfRounds,
    );

    // 3. Fetch only the specific items we need
    final items = await ref.read(collectionItemsByIdsProvider(itemIds).future);

    if (items.isEmpty || items.length < numberOfRounds * 2) {
      throw Exception('Failed to load required items');
    }

    // 4. Create the game session with the fetched items
    // Use the same sessionId that was used to generate the items
    final session = gameService.createGameSession(
      mode: mode,
      items: items,
      numberOfRounds: numberOfRounds,
    );

    state = session;
  }

  /// Submits a user estimate for the current round
  void submitEstimate(double userEstimate) {
    if (state == null) {
      throw Exception('No active game session');
    }

    final gameService = ref.read(gameServiceProvider);
    state = gameService.submitRoundEstimate(
      session: state!,
      userEstimate: userEstimate,
    );
  }

  /// Returns the current round of the active session
  GameRound? getCurrentRound() {
    if (state == null || state!.currentRoundIndex >= state!.rounds.length) {
      return null;
    }
    return state!.rounds[state!.currentRoundIndex];
  }

  /// Returns the total score of the active session
  double getTotalScore() {
    if (state == null) {
      return 0;
    }

    final gameService = ref.read(gameServiceProvider);
    return gameService.calculateTotalScore(state!);
  }

  /// Ends the current session
  void endSession() {
    state = null;
  }
}

/// Provider for the game timer
@riverpod
class GameTimerNotifier extends _$GameTimerNotifier {
  int _remainingSeconds = 0;

  @override
  int build() {
    // Start with 0 seconds
    return 0;
  }

  /// Starts the timer based on the game mode
  void startTimer(GameMode mode) {
    // Reset any existing timer
    cancelTimer();

    // Set the initial time based on game mode
    _remainingSeconds =
        mode == GameMode.simple ? 30 : 180; // 30 seconds or 3 minutes
    state = _remainingSeconds;

    // Update the timer every second
    _startCountdown();
  }

  /// Starts the countdown timer
  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        state = _remainingSeconds;
        _startCountdown(); // Continue the countdown
      }
    });
  }

  /// Cancels the current timer
  void cancelTimer() {
    _remainingSeconds = 0;
    state = 0;
  }

  /// Returns true if the timer has expired
  bool isExpired() {
    return _remainingSeconds <= 0;
  }
}
