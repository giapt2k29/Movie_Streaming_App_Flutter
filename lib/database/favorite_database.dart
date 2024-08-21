import 'package:flutter/material.dart';

import 'favorite_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:movie_streaming_app/Model/favorite.dart';

class FavoriteDB {
  final tableName = 'favorites';

  Future<void> createTable(Database database) async {
    await database.execute('''
    CREATE TABLE IF NOT EXISTS $tableName (
      slug TEXT NOT NULL,
      PRIMARY KEY(slug)
    );
  ''');
  }

  Future<int> create({required String slug}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (slug) VALUES (?)''',
      [slug],
    );
  }

  Future<List<Favorite>> fetchAll() async {
    final database = await DatabaseService().database;
    final favorites = await database.rawQuery(
      '''SELECT * from $tableName'''
    );
    return favorites.map((favorite) => Favorite.fromSqfliteDatabase(favorite)).toList();
  }
  
  Future<void> delete(String slug) async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $tableName WHERE slug = ?''', [slug]);
  }
}