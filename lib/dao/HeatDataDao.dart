import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:danceframe_et/model/HeatData.dart';

class HeatDataDao {

  static Future saveHeatData(HeatData h) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(HeatData.tableName, h.toMap());
    return id;
  }

  static Future getHeatDataById(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query(HeatData.tableName,
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return HeatData.fromMap(maps.first);
    }
    return null;
  }

  static Future getHeatDataByJudge(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<HeatData> heats = [];
    List<Map> result = await db.query(HeatData.tableName,
        where: 'judge_id = ?',
        whereArgs: [id],
        orderBy: 'heat_order');
    if (result.length > 0) {
      for(Map row in result) {
        print(row);
        heats.add(new HeatData.fromMap(row));
      }
      return heats;
    }
    return null;
  }

  static Future saveAllHeatData(List<HeatData> heats) async {
    Database db = await DatabaseHelper.instance.database;
    for(HeatData heat in heats) {
      int id = await db.insert(HeatData.tableName, heat.toMap());
    }
  }
}