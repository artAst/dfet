import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:danceframe_et/model/Judge.dart';

class JudgeDao {

  static Future saveJudge(Judge judge) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert("judge", judge.toMap());
    return id;
  }

  static Future getJudgeById(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query("judge",
//        columns: [columnId, columnWord, columnFrequency],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      print(maps.first);
      return Judge.fromMap(maps.first);
    }
    return null;
  }

  static Future getJudgesList() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("judge");
    List<Judge> judges = [];
    for(Map row in result) {
      print(row);
      judges.add(new Judge.fromMap(row));
    }
    return judges;
  }

  // missing implementation
  static Future getJudgeByName(String name) async {
    Database db = await DatabaseHelper.instance.database;
  }
}