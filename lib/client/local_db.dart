import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';

part 'local_db.g.dart';

/// Provider for the local database client
@Riverpod(keepAlive: true)
Future<JsonSqFliteStorage> localDbClient(Ref ref) async {
  return JsonSqFliteStorage.open(
    join(await getDatabasesPath(), 'local_db.db'),
  );
}
