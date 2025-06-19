import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../providers/collection/collection_providers.dart';
import '../../../router/router.dart';

part 'ratio_controller.g.dart';

@riverpod
class RatioController extends _$RatioController {
  double minRatio = 0.01;

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
          .select((collection) => collection.valueOrNull?.ratioBoundary),
      (_, ratioBoundary) {
        minRatio =
            pow(10, (log(ratioBoundary ?? 0.01) / log(10)).floor()).toDouble();
      },
      fireImmediately: true,
    );

    return 1.5;
  }

  void set(double ratio) {
    state = ratio.clamp(minRatio, 1 / minRatio);
  }

  void reset() {
    state = 1.5;
  }
}
