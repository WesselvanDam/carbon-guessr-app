import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ratio_controller.g.dart';

@riverpod
class RatioController extends _$RatioController {
  @override
  double build() {
    return 1.5;
  }

  void set(double ratio) {
    state = ratio;
  }

  void reset() {
    state = 1.5;
  }
}
