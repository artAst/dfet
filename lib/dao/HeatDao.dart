import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:danceframe_et/model/Heat.dart';

class HeatDao {
  static Future getHeatInfoById(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query("heat_info",
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return HeatInfo.fromMap(maps.first);
    }
    return null;
  }
}