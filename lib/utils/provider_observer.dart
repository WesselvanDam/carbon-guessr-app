// ignore_for_file: missing_whitespace_between_adjacent_strings

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodProviderObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) =>
      debugPrint(
        '\x1B[34m'
        '$provider Added\x1B[0m'
        '',
      );

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) =>
      debugPrint(
        '\x1B[35m'
        '$provider Disposed\x1B[0m'
        '',
      );

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (provider.name?.contains('gameTimerProvider') == true || provider.name?.contains('ratioControllerProvider') == true) return;
      debugPrint(
        '\x1B[33m'
        '$provider Updated:\n'
        '\tPrevious Value: $previousValue\n'
        '\tNew Value: $newValue\x1B[0m\n'
        '',
      );
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) =>
      debugPrint(
        '\x1B[31m'
        '$stackTrace\n'
        '$provider Error: $error\x1B[0m\n'
        '',
      );
}
