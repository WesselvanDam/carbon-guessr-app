// ignore_for_file: missing_whitespace_between_adjacent_strings

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodProviderObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderObserverContext context,
    Object? value,
  ) =>
      debugPrint(
        '\x1B[34m'
        '${context.provider} Added\x1B[0m'
        '',
      );

  @override
  void didDisposeProvider(
    ProviderObserverContext context,
  ) =>
      debugPrint(
        '\x1B[35m'
        '${context.provider} Disposed\x1B[0m'
        '',
      );

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (context.provider.name?.contains('timerControllerProvider') == true ||
        context.provider.name?.contains('ratioControllerProvider') == true) {
      return;
    }
    debugPrint(
      '\x1B[33m'
      '${context.provider} Updated:\n'
      '\tPrevious Value: $previousValue\n'
      '\tNew Value: $newValue\x1B[0m\n'
      '',
    );
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) =>
      debugPrint(
        '\x1B[31m'
        '$stackTrace\n'
        '${context.provider} Error: $error\x1B[0m\n'
        '',
      );
}
