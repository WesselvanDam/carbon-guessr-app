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
          path: '/onboarding',
          factory: $OnboardingRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/',
          factory: $HomeRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'collection/:cid',
              factory: $CollectionRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'game/:gid',
                  factory: $GameRouteExtension._fromState,
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

extension $OnboardingRouteExtension on OnboardingRoute {
  static OnboardingRoute _fromState(GoRouterState state) =>
      const OnboardingRoute();

  String get location => GoRouteData.$location(
        '/onboarding',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
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

extension $CollectionRouteExtension on CollectionRoute {
  static CollectionRoute _fromState(GoRouterState state) => CollectionRoute(
        cid: state.pathParameters['cid']!,
      );

  String get location => GoRouteData.$location(
        '/collection/${Uri.encodeComponent(cid)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GameRouteExtension on GameRoute {
  static GameRoute _fromState(GoRouterState state) => GameRoute(
        cid: state.pathParameters['cid']!,
        gid: state.pathParameters['gid']!,
        mode: _$GameModeEnumMap._$fromName(state.uri.queryParameters['mode']!)!,
      );

  String get location => GoRouteData.$location(
        '/collection/${Uri.encodeComponent(cid)}/game/${Uri.encodeComponent(gid)}',
        queryParams: {
          'mode': _$GameModeEnumMap[mode],
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$GameModeEnumMap = {
  GameMode.simple: 'simple',
  GameMode.challenge: 'challenge',
};

extension<T extends Enum> on Map<T, String> {
  T? _$fromName(String? value) =>
      entries.where((element) => element.value == value).firstOrNull?.key;
}
