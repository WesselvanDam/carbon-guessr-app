import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../providers/game/game_providers.dart';
import '../../../utils/extensions.dart';

part 'timer_controller.g.dart';

@riverpod
class TimerController extends _$TimerController {
  Timer? _timer;

  @override
  int? build() {
    // Clean up timer when the provider is disposed
    ref.onDispose(() => _timer?.cancel());

    return null;
  }

  void start() {
    // Cancel any existing timer
    cancel();

    state = ref.read(gameModeProvider).roundDurationInSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state != null && state! > 0) {
        state = state! - 1;
      } else {
        _timer?.cancel();
      }
    });
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
    state = null;
  }
}
