import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity.g.dart';

@riverpod
Stream<bool> hasInternetConnection(Ref ref) async* {
  final connectionStream = InternetConnection().onStatusChange;

  await for (final status in connectionStream) {
    yield status == InternetStatus.connected;
  }
}
