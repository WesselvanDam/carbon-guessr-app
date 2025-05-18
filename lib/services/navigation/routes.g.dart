// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $shellRoute,
    ];

RouteBase get $shellRoute => ShellRouteData.$route(
      factory: $ShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/',
          factory: $HomeRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'collection',
              factory: $CollectionListRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'collection/:id',
                  factory: $CollectionDetailRouteExtension._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'game',
              factory: $GameModeSelectionRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'round',
                  factory: $GameRoundRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'results',
                  factory: $GameResultsRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $ShellRouteExtension on ShellRoute {
  static ShellRoute _fromState(GoRouterState state) => const ShellRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CollectionListRouteExtension on CollectionListRoute {
  static CollectionListRoute _fromState(GoRouterState state) =>
      const CollectionListRoute();

  String get location => GoRouteData.$location(
        '/collection',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CollectionDetailRouteExtension on CollectionDetailRoute {
  static CollectionDetailRoute _fromState(GoRouterState state) =>
      CollectionDetailRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/collection/collection/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GameModeSelectionRouteExtension on GameModeSelectionRoute {
  static GameModeSelectionRoute _fromState(GoRouterState state) =>
      const GameModeSelectionRoute();

  String get location => GoRouteData.$location(
        '/game',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GameRoundRouteExtension on GameRoundRoute {
  static GameRoundRoute _fromState(GoRouterState state) =>
      const GameRoundRoute();

  String get location => GoRouteData.$location(
        '/game/round',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GameResultsRouteExtension on GameResultsRoute {
  static GameResultsRoute _fromState(GoRouterState state) =>
      const GameResultsRoute();

  String get location => GoRouteData.$location(
        '/game/results',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
