import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:danceframe_et/model/Heat.dart';

class CritiqueDao {

  static Future saveCritique(critique, int type) async {
    Database db = await DatabaseHelper.instance.database;
    print("saving critique sheet $type");
    int id = await db.insert("critique_sheet_$type", critique.toMap());
    return id;
  }

  static Future updateCritique(critiqueId, critique, int type) async {
    Database db = await DatabaseHelper.instance.database;
    print("updating critique sheet $type");
    int id = await db.update("critique_sheet_$type", critique.toMap(),
        where: 'id = ?',
        whereArgs: [critiqueId]);
    return id;
  }

  static Future getCritiqueById(String id, int type) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query("critique_sheet_$type",
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      print(maps.first);
      if(type == 1)
        return CritiqueData1.fromMap(maps.first);
      else
        return CritiqueData2.fromMap(maps.first);
    }
    return null;
  }
}