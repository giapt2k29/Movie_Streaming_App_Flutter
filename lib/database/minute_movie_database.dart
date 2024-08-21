import 'minute_movie_service.dart';
import 'package:movie_streaming_app/Model/minute_of_movie.dart';
import 'package:sqflite/sqflite.dart';

class MovieDB {
  final tableName = 'minutes';

  Future<void> createTable(Database database) async {
    await database.execute('''
    CREATE TABLE IF NOT EXISTS $tableName (
      link TEXT NOT NULL,
      minute_movie INT,
      PRIMARY KEY(link)
      );
      ''');
  }

  Future<int> create({required String link, required int minute}) async {
    final database = await MovieMinuteService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (link, minute_movie) VALUES (?, ?)''',
      [link, minute],
    );
  }

  Future<List<MinuteMovie>> fetchAll() async {
    final database = await MovieMinuteService().database;
    final minutes = await database.rawQuery(
        '''SELECT * from $tableName'''
    );
    return minutes.map((minute) => MinuteMovie.fromSqfliteDatabase(minute)).toList();
  }


  Future<int> update({required String link, required int minute}) async {
    final database = await MovieMinuteService().database;
    return await database.rawUpdate(
      '''UPDATE $tableName SET minute_movie = ? WHERE link = ?''',
      [minute, link],
    );
  }

}