import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../router/router.dart';
import '../../collection/providers/collection_providers.dart';

part 'ratio_controller.g.dart';

@riverpod
class RatioController extends _$RatioController {
  double _minRatio = 0.01;

  @override
  double build() {
    final cid = ref.read(routerProvider
        .select((router) => router.state.pathParameters['cid'] ?? ''));

    // Set the minRatio based on the collection's ratio boundary. This is used to
    // ensure that the ratio is not set to unnaturally high or low values.
    // The ratio boundary is defined in the collection's metadata and is defined
    // as the smallest ratio that can be achieved with the collection's items.
    ref.listen(
      collectionProvider(cid)
          .select((collection) => collection.value?.ratioBoundary),
      (_, ratioBoundary) {
        _minRatio =
            pow(10, (log(ratioBoundary ?? 0.01) / log(10)).floor()).toDouble();
      },
      fireImmediately: true,
    );

    return 1.5;
  }

  void set(double ratio) {
    state = ratio.clamp(_minRatio, 1 / _minRatio);
  }

  void reset() {
    state = 1.5;
  }
}
