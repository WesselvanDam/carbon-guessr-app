import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../client/talker.dart';
import '../local_storage/local_storage_keys.dart';
import '../local_storage/local_storage_repository.dart';
import 'routes.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

  final initialLocation = ref.watch(initialLocationProvider);

  final router = GoRouter(
    navigatorKey: key,
    observers: [TalkerRouteObserver(talker)],
    initialLocation: initialLocation,
    routes: $appRoutes,
    redirect: (context, state) => redirect(ref, context, state),
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('404'))),
  );

  ref.onDispose(router.dispose);

  return router;
}

@riverpod
String initialLocation(Ref ref) {
  final hasSeenOnboarding =
      ref
          .read(localStorageRepositoryProvider)
          .getBool(LocalStorageBoolKeys.hasSeenOnboarding) ??
      false;
  return hasSeenOnboarding ? '/' : '/onboarding';
}

Future<String?> redirect(
  Ref ref,
  BuildContext context,
  GoRouterState state,
) async {
  return null;
}
