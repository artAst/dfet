import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:danceframe_et/model/Heat.dart';

class HeaInfoDao {
  // missing info
  static Future saveHeatData(CritiqueData1 heat) async {
    Database db = await DatabaseHelper.instance.database;
  }

  static Future getHeatInfoById(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query("heat_info",
//        columns: [columnId, columnWord, columnFrequency],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      print(maps.first);
      return HeatInfo.fromMap(maps.first);
    }
    return null;
  }

  static Future getHeatInfoList() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("heat_info");
    List<HeatInfo> heatInfos = [];
    result.forEach((row) {
      print(row);
      heatInfos.add(new HeatInfo.fromMap(row));
    });
  }
}