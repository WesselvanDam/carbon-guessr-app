import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_timer_provider.g.dart';

@Riverpod(keepAlive: true)
class GameTimer extends _$GameTimer {
  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  int build() {
    // Clean up timer when the provider is disposed
    ref.onDispose(() {
      _timer?.cancel();
    });
    
    return 0;
  }

  void startTimer(int seconds) {
    // Cancel any existing timer
    cancelTimer();
    
    // Set initial time and start the timer
    _remainingSeconds = seconds;
    state = _remainingSeconds;
    
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        state = _remainingSeconds;
      } else {
        _timer?.cancel();
        // TODO: Handle timer expiration, e.g., notify the game session
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
    _remainingSeconds = 0;
    state = 0;
  }
}
