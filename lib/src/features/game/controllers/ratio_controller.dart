import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/game_providers.dart';

part 'ratio_controller.g.dart';

@riverpod
class RatioController extends _$RatioController {
  static const double _defaultRatio = 3;
  late double _minRatio;

  @override
  double build() {
    _minRatio = ref.watch(minRatioProvider);

    return _defaultRatio;
  }

  void set(double ratio) {
    state = ratio.clamp(_minRatio, 1 / _minRatio);
  }

  void reset() {
    state = _defaultRatio;
  }
}
