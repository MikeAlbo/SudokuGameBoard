import 'dart:async';
import 'dart:io';

import 'package:basic_game/api/db/tables/game_state_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// db api for
///
/// the sqf lite interface for local device file storage

var readyCompleter = Completer();
Future get ready => readyCompleter.future;

class DbAPI {
  late Database db;

  String dbName = "sudokuV1"; // update name to change db name

  DbAPI() {
    _initDb(dbName: dbName).then((_) => readyCompleter.complete);
  }

  _initDb({required String dbName}) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) async {
      await newDb.execute(buildGameStateTable());
    });
    print("db initialize");
  }
}
