import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class PiContentDao {

  static Future truncateTables() async {
    Database db = await DatabaseHelper.instance.database;
    await db.delete("pi_panel_info");
    await db.delete("pi_heat");
    await db.delete("pi_sub_heat");
    await db.delete("pi_entry");
    await db.delete("pi_couple");
    await db.delete("pi_person");
    await db.delete("pi_people");
    await db.delete("pi_assignment");
  }

  static Future saveAllPanelInfo(panelInfo) async {
    Database db = await DatabaseHelper.instance.database;
    for(var p in panelInfo) {
      int id = await db.insert("pi_panel_info", p);
    }
  }

  static Future getAllPanelInfo() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("pi_panel_info");
    print("PANEL INFO SAVED: [${result.length}]");
    return result;
  }

  static Future saveHeat(h) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert("pi_heat", {
      "heatId": h["heatId"],
      "heatName": h["heatName"],
      "heatSession": h["heatSession"],
      "heatTime": h["heatTime"],
      "heatDesc": h["heatDesc"],
      "panelId": h["panelId"],
      "is_started": 0
    });
  }

  static Future saveSubHeat(s) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert("pi_sub_heat", {
      "subHeatId": s["subHeatId"],
      "sequenceId": s["sequenceId"],
      "subHeatType": s["subHeatType"],
      "subHeatDance": s["subHeatdance"],
      "subHeatLevel": s["subHeatlevel"],
      "subHeatAge": s["subHeatAge"],
      "heatId": s["heatId"],
    });
  }

  static Future saveEntry(e, subHeatId, heatId) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert("pi_entry", {
      "entryId": e["entryId"],
      "entryKey": e["entryKey"],
      "entryType": e["entryType"],
      "status": e["status"],
      "peopleId": e["peopleId"],
      "judgeNum": e["judgeNum"],
      "subSeqId": e["subSeqId"],
      "studioName": e["studioName"],
      "studioKey": e["studioKey"],
      "subHeatId": subHeatId,
      "heatId": heatId,
    });
    //print("ENTRY SAVED ID[$id], SUB HEAT ID: [$subHeatId]");
  }

  static Future savePeople(p) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert("pi_people", {
      "peopleId": p["peopleId"],
      "peopleKey": p["peopleKey"],
      "peopleName": p["peopleName"],
      "judgeNumber": p["judgeNumber"],
      "uploadId": p["uploadId"]
    });
    //print("ENTRY SAVED ID[$id], SUB HEAT ID: [$subHeatId]");
    return id;
  }

  static Future saveAssignment(a, peopleId) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert("pi_assignment", {
      "peopleId": peopleId,
      "panelId": a["panelId"],
      "role": a["role"],
      "time": a["time"],
      "panelDate": a["panelDate"],
      "session": a["session"]
    });
    //print("ENTRY SAVED ID[$id], SUB HEAT ID: [$subHeatId]");
  }

  static Future saveCouple(e) async {
    Database db = await DatabaseHelper.instance.database;
    try {
      String queryStr = "INSERT OR IGNORE INTO pi_couple(coupleKey, coupleId, uploadId, category, booked, scratched, danced, future, total) VALUES('${e["coupleKey"]}', ${e["coupleId"]}, ${e["uploadId"]}, '${e["category"]}', ${e["heatSummary"]["booked"]}, ${e["heatSummary"]["scratched"]}, ${e["heatSummary"]["danced"]}, ${e["heatSummary"]["future"]}, ${e["heatSummary"]["total"]})";
      int id = await db.rawInsert(queryStr);

      /*int id = await db.insert("pi_couple", {
        "coupleId": e["coupleId"],
        "coupleKey": e["coupleKey"],
        "uploadId": e["uploadId"],
      });*/
    } catch(e) {
      print("INSERT ERROR: ${e.message}");
      print("{coupleId: ${e["coupleId"]}, coupleKey: ${e["coupleKey"]}, uploadId: ${e["uploadId"]}");
    }
  }

  static Future savePerson(p, coupleKey) async {
    Database db = await DatabaseHelper.instance.database;
    try {
      int id = await db.rawInsert("INSERT OR REPLACE INTO pi_person(personKey, firstName, lastName, gender, personType, studioId, studioKey, nickName, competitorNumber, studioName, studioIndependentInvoice, uploadId, coupleKey) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", [
        p["personKey"],
        p["firstName"],
        p["lastName"],
        p["gender"],
        p["personType"],
        p["studioId"],
        p["studioKey"],
        p["nickName"],
        p["competitorNumber"],
        p["studioName"],
        p["studioIndependentInvoice"],
        p["uploadId"],
        coupleKey
      ]);
      //print("PI_PERSON ID[$id] ${p["firstName"]} ${p["lastName"]}");
      /*if(coupleId == 27) {
        print("PI_PERSON ID[$id] ${p["firstName"]} ${p["lastName"]}");
      }*/
    } catch(e) {
      print("INSERT ERROR: ${e.message}");
      print("{personId: ${p["personId"]}, firstName: ${p["firstName"]}, lastName: ${p["lastName"]}");
    }
  }

  static Future getAllCouples() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("pi_couple");
    print("SAVED COUPLES: [${result.length}]");
    return result;
  }

  static Future getAllPersons() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("pi_person");
    print("SAVED PERSONS: [${result.length}]");
    return result;
  }

  static Future getAllPeople() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("pi_people");
    print("SAVED PEOPLE: [${result.length}]");
    return result;
  }

  static Future getAllAssignments() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("pi_assignment");
    print("SAVED ASSIGNMENTS: [${result.length}]");
    return result;
  }

  static Future getAllHeats() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("pi_heat");
    print("HEATS SAVED IN PI_HEAT: [${result.length}]");
    return result;
  }

  static Future getAllHeatsByPanelId(id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("pi_heat",
      where: 'panelId = ?',
      whereArgs: [id]
    );
    print("Panel ID[$id] HEATS IN PI_HEAT: [${result.length}]");
    return result;
  }

  static Future getAllSubHeatsByHeatId(id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("pi_sub_heat",
        where: 'heatId = ?',
        whereArgs: [id]
    );
    print("Heat ID[$id] SUBHEATS IN PI_SUB_HEAT: [${result.length}]");
    return result;
  }

  static Future getAllEntriesBySubHeatId(id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("pi_entry",
        where: 'subHeatId = ?',
        whereArgs: [id]
    );
    print("SubHeat ID[$id] ENTRIES IN PI_ENTRY: [${result.length}]");
    return result;
  }

  static Future getCoupleByEntryKey(id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("pi_couple",
        where: "coupleKey = ?",
        whereArgs: [id]
    );
    print("Couple ID[$id] Couples IN PI_COUPLE: [${result.length}]");
    return result.first;
  }

  static Future getPersonsByCoupleKey(id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("pi_person",
      where: 'coupleKey = ?',
      whereArgs: [id]);
    print("Couple ID[$id] Persons IN PI_PERSON: [${result.length}]");
    return result;
  }
}