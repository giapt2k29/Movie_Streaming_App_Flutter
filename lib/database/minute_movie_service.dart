import 'package:movie_streaming_app/database/minute_movie_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'minute_movie_database.dart';

class MovieMinuteService{
  Database? _database;

  Future<Database> get database async {
    if(_database != null) {
      return _database!;
    }

    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'minute.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    await MovieDB().createTable(database);
  }
}