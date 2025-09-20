import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/game_providers.dart';

part 'ratio_controller.g.dart';

@riverpod
class RatioController extends _$RatioController {
  late double _minRatio;

  @override
  double build() {
    _minRatio = ref.watch(minRatioProvider);

    return 1.5;
  }

  void set(double ratio) {
    state = ratio.clamp(_minRatio, 1 / _minRatio);
  }

  void reset() {
    state = 1.5;
  }
}
