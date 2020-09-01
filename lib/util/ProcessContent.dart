import 'package:danceframe_et/enums/UserProfiles.dart';
import 'package:danceframe_et/enums/AcessPermissions.dart';
import 'package:danceframe_et/model/JobPanel.dart';
import 'package:danceframe_et/model/config/EventConfig.dart';
import 'package:danceframe_et/model/config/Global4Config.dart';
import 'package:danceframe_et/dao/PiContentDao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:danceframe_et/util/Preferences.dart';

class ProcessContent {

  static Future _saveAllPanelInfo(panelInfo) async {
    Database db = await DatabaseHelper.instance.database;
    for(var p in panelInfo) {
      int id = await db.insert("pi_panel_info", {
        "jobPanelId": p["panelId"],
        "jobPanelTime": p["panelTime"],
        "jobPanelDate": p["panelDate"],
        "jobSession": p["panelSession"]
      });
    }
  }

  static Future _saveHeat(h, Batch b) async {
    //Database db = await DatabaseHelper.instance.database;
    await b.insert("pi_heat", {
      "heatId": h["heatId"],
      "heatName": h["heatName"],
      "heatSession": h["heatSession"],
      "heatTime": h["heatTime"],
      "heatDesc": h["heatDesc"],
      "panelId": h["panelId"],
      "is_started": 0
    });
  }

  static Future _saveSubHeat(s, Batch b) async {
    //Database db = await DatabaseHelper.instance.database;
    await b.insert("pi_sub_heat", {
      "subHeatId": s["subHeatId"],
      "sequenceId": s["sequenceId"],
      "subHeatType": s["subHeatType"],
      "subHeatDance": s["subHeatdance"],
      "subHeatLevel": s["subHeatlevel"],
      "subHeatAge": s["subHeatAge"],
      "heatId": s["heatId"],
    });
  }

  static Future _saveEntry(e, subHeatId, heatId, Batch b) async {
    await b.insert("pi_entry", {
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

  static Future loadEventConfig(e) async {
    EventConfig conf = new EventConfig(e["eventName"],
        "${e["eventDate"]} ${e["eventTime"]}", e["screenTimeout"]);
    print("EVENT CONFIG EventName: ${EventConfig.eventName}");
    print("EVENT CONFIG EventDate: ${EventConfig.eventDate}");
    print("EVENT CONFIG EventYear: ${EventConfig.eventYear}");
    print("EVENT CONFIG EventTime: ${EventConfig.eventTime}");
  }

  static loadTimeoutConfig(e) async {
    for (var i = 0; i < e.length; i++) {
      print(e[i]["jobType"]);
      //store
      Preferences.setSharedValue(
          e[i]["jobType"],
          "enabled:" +
              e[i]["enabled"].toString() +
              ",timeoutVal:" +
              e[i]["timeoutVal"].toString());
    }
  }

  static Future loadEventPermission(e) async {
    List<JobPanel> jobPanelList = [];
    for (var m in e) {
      JobPanel _jobpanel = new JobPanel.fromMap(m);
      jobPanelList.add(_jobpanel);
    }
    Map<AccessPermissions, List<UserProfiles>> rolePermissions = {};
    for(var jp in jobPanelList) {
      List<UserProfiles> _tempAccess = [];
      if(jp.judge) {
        _tempAccess.add(UserProfiles.JUDGE);
      }
      if(jp.scrutineer) {
        _tempAccess.add(UserProfiles.SCRUTINEER);
      }
      if(jp.emcee) {
        _tempAccess.add(UserProfiles.EMCEE);
      }
      if(jp.chairman) {
        _tempAccess.add(UserProfiles.CHAIRMAN_OF_JUDGES);
      }
      if(jp.deck) {
        _tempAccess.add(UserProfiles.DECK_CAPTAIN);
      }
      if(jp.registrar) {
        _tempAccess.add(UserProfiles.REGISTRAR);
      }
      if(jp.musicDj) {
        _tempAccess.add(UserProfiles.MUSIC_DJ);
      }
      if(jp.photosVideo) {
        _tempAccess.add(UserProfiles.PHOTOS_VIDEOS);
      }
      if(jp.hairMakeup) {
        _tempAccess.add(UserProfiles.HAIR_MAKEUP);
      }

      switch(jp.description.toString().toLowerCase()) {
        case "access to critique module":
          rolePermissions.putIfAbsent(AccessPermissions.CRITIQUE_MODULE, () => _tempAccess);
          break;
        case "access to heatlist module":
          rolePermissions.putIfAbsent(AccessPermissions.HEAT_LIST, () => _tempAccess);
          break;
        case "view all heats and participants":
          rolePermissions.putIfAbsent(AccessPermissions.VIEW_ALL_HEATS_PARTICIPANTS, () => _tempAccess);
          break;
        case "scratch competitors":
          rolePermissions.putIfAbsent(AccessPermissions.SCRATCH_COMPETITORS, () => _tempAccess);
          break;
        case "unscratch competitors":
          rolePermissions.putIfAbsent(AccessPermissions.UN_SCRATCH_COMPETITORS, () => _tempAccess);
          break;
        case "manage couple":
          rolePermissions.putIfAbsent(AccessPermissions.MANAGE_COUPLE, () => _tempAccess);
          break;
        case "add schedule judging panel":
          rolePermissions.putIfAbsent(AccessPermissions.SCHEDULE_JUDGING_PANEL, () => _tempAccess);
          break;
        case "mark couple check":
          rolePermissions.putIfAbsent(AccessPermissions.MARK_COUPLE, () => _tempAccess);
          break;
        case "statistics event monitoring test":
          rolePermissions.putIfAbsent(AccessPermissions.EVENT_MONITORING_STATISTICS, () => _tempAccess);
          break;
        default:
      }
    }
    Global4Config global4config = new Global4Config(permissions: jobPanelList, rolePermissions: rolePermissions);
  }

  static Future _saveCouple(e, Batch b) async {
    //Database db = await DatabaseHelper.instance.database;
    try {
      String queryStr = "INSERT OR IGNORE INTO pi_couple(coupleKey, coupleId, uploadId, category, booked, scratched, danced, future, total) VALUES('${e["coupleKey"]}', ${e["coupleId"]}, ${e["uploadId"]}, '${e["category"]}', ${e["heatSummary"]["booked"]}, ${e["heatSummary"]["scratched"]}, ${e["heatSummary"]["danced"]}, ${e["heatSummary"]["future"]}, ${e["heatSummary"]["total"]})";
      await b.rawInsert(queryStr);

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

  static Future _savePerson(p, coupleKey, Batch b) async {
    //Database db = await DatabaseHelper.instance.database;
    try {
      await b.rawInsert("INSERT OR REPLACE INTO pi_person(personKey, firstName, lastName, gender, personType, studioId, studioKey, nickName, competitorNumber, studioName, studioIndependentInvoice, uploadId, coupleKey) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", [
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

  static saveAllJobPanels(resp, Function f) async {
    double loadDivision = 0.1 / resp.length;
    await _saveAllPanelInfo(resp);
    //await PiContentDao.getAllPanelInfo();
    for(var item in resp) {
      print("PANEL[${item["panelId"]}]");
      await saveAllHeats(item);
      Function.apply(f, [loadDivision]);
    }
    if (resp.length <= 0) Function.apply(f, [0.6]);
  }

  static saveAllHeats(resp) async {
    Database db = await DatabaseHelper.instance.database;
    Batch b = db.batch();
    int heatCnt = 0;
    for (var h in resp["heats"]) {
      int subCnt = 0;
      int entryCnt = 0;
      await _saveHeat(h, b);
      heatCnt += 1;
      // save sub heats
      for (var s in h["subheats"]) {
        await _saveSubHeat(s, b);
        subCnt += 1;
        // save entries
        for (var e in s["entries"]) {
          await _saveEntry(e, s["subHeatId"], s["heatId"], b);
          entryCnt += 1;
        }
      }
      //print("SUB HEATS: [$subCnt]");
      //print("ENTRIES: [$entryCnt]");
    }
    await b.commit(noResult: true);
    print("HEATS[$heatCnt]");
  }

  static saveAllCouples(resp) async {
    Database db = await DatabaseHelper.instance.database;
    Batch b = db.batch();
    int coupleCnt = 0;
    for (var c in resp) {
      //if(c != null && c["coupleId"] != null) {
      var couple_key = await _saveCouple(c, b);
      if(couple_key != null)
        coupleCnt++;
      // save persons
      for (var p in c["persons"]) {
        await _savePerson(p, c["coupleKey"], b);
      }
    }
    await b.commit(noResult: true);
    print("COUPLES[$coupleCnt]");
  }

  static saveAllPeople(resp) async {
    int peopleCnt = 0;
    for (var p in resp) {
      int peopleId = await PiContentDao.savePeople(p);
      //if(peopleId != null)
      peopleCnt++;

      for (var a in p["assignments"]) {
        int assignmentId = await PiContentDao.saveAssignment(a, peopleId);
      }
    }
    print("PEOPLE[$peopleCnt]");
  }
}