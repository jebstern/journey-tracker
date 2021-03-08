import 'dart:io';
import 'package:journey_tracker/model/challenge_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String dbName = 'season21';
final String tableChallenges = 'challenges';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnChapter = 'chapter';
final String columnIsCompleted = 'isCompleted';
final String createChallengeSql = "CREATE TABLE $tableChallenges ("
    "$columnId INTEGER AUTO_INCREMENT PRIMARY KEY,"
    "$columnTitle TEXT,"
    "$columnChapter TEXT,"
    "$columnIsCompleted INTEGER DEFAULT 0)";

class DBProvider {
  static Database _db;

  Future<void> initDb() async {
    print("initDb");
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, dbName);
    _db = await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute(createChallengeSql);
    });
  }

  Future<int> getAllChecked() async {
    List<Map<String, dynamic>> result = await _db.rawQuery('SELECT COUNT(*) as checked FROM $tableChallenges WHERE $columnIsCompleted=1');
    Map<String, dynamic> row = result.first;
    return row['checked'];
  }

  Future<bool> toggleCompleted(Challenge challenge) async {
    print("toggleCompleted - isCompleted: ${challenge.isCompleted}");
    int isUpdated = 0;
    List<Map<String, dynamic>> result = await _db.rawQuery("SELECT COUNT(*) rows FROM $tableChallenges WHERE $columnTitle = ? AND $columnChapter = ?", [challenge.title, challenge.chapter]);
    int rows = result.first["rows"];
    if (rows == 0) {
      isUpdated = await _db.rawUpdate("INSERT INTO $tableChallenges($columnTitle, $columnChapter, $columnIsCompleted) VALUES (?, ?, ?)", [challenge.title, challenge.chapter, 1]);
    } else {
      isUpdated = await _db.rawUpdate('UPDATE $tableChallenges SET $columnIsCompleted = ? WHERE $columnTitle = ? AND $columnChapter = ?',
          [challenge.isCompleted == true ? 1 : 0, challenge.title, challenge.chapter]);
    }
    return isUpdated == 1;
  }

  Future<List<Challenge>> getChallengesFromChapter(String chapter) async {
    final List<Map<String, dynamic>> maps = await _db.query(tableChallenges, where: '$columnChapter = ?', whereArgs: [chapter]);
    return List.generate(maps.length, (i) {
      return Challenge(
        chapter: maps[i]['chapter'],
        title: maps[i]['title'],
        isCompleted: maps[i]['isCompleted'] == 1,
      );
    });
  }

  Future close() async => _db.close();
}
