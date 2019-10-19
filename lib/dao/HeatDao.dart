import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:danceframe_et/model/Heat.dart';

class HeatDao {

  static Future getAllHeat() async {
    Database db = await DatabaseHelper.instance.database;
    List<HeatInfo> heats = [];
    List<Map> result = await db.query("heat_info");
    for(Map row in result) {
      print(row);
      heats.add(new HeatInfo.fromMap(row));
    }
    return heats;
  }

  static Future getHeatInfoById(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query("heat_local",
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return HeatInfo.fromMap(maps.first);
    }
    return null;
  }

  static Future getHeatsByJudge(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<HeatInfo> heats = [];
    List<Map> result = await db.query("heat_local",
        where: 'judge_id = ?',
        whereArgs: [id],
        orderBy: 'heat_order');
    if (result.length > 0) {
      for(Map row in result) {
        print(row);
        heats.add(new HeatInfo.fromMap(row));
      }
      return heats;
    }
    return null;
  }

  static Future saveHeat(HeatInfo heat) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert("heat_local", heat.toMap());
    return id;
  }

  static Future saveAllHeats(List<HeatInfo> heats) async {
    Database db = await DatabaseHelper.instance.database;
    for(HeatInfo heat in heats) {
      int id = await db.insert("heat_local", heat.toMap());
    }
  }

  static Future removeHeatLocal() async {
    Database db = await DatabaseHelper.instance.database;
    db.rawDelete("DELETE FROM heat_local");
  }
}