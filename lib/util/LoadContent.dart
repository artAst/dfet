import 'package:danceframe_et/util/ConfigUtil.dart';
import 'package:danceframe_et/util/HttpUtil.dart';
import 'package:danceframe_et/dao/PiContentDao.dart';
import 'package:danceframe_et/model/Heat.dart';

class LoadContent {
  static String baseUri;
  
  static loadUriConfig() async {
    String confValue = await ConfigUtil.getConfig("app_local_server");
    if(confValue != null) {
      baseUri = confValue;
    }
  }

  static Future cleanPiTables() async {
    return PiContentDao.truncateTables();
  }

  static Future sendCritique(context, Map<String, dynamic> reqBody) async {
    var resp = await HttpUtil.postRequest(context, baseUri + "/pfws/critique/input", reqBody);
  }

  static Future uploadImg(context, file) async {
    var resp = await HttpUtil.uploadImage(context, baseUri + "/pfws/upload", file);
    // return image upload ID
    if(resp != null && resp["uploadId"] != null) {
      return resp["uploadId"];
    } else {
      return null;
    }
  }

  static Future saveJudgeInitials(context, Map<String, dynamic> reqBody) async {
    var resp = await HttpUtil.postRequest(context, baseUri + "/pfws/people/initials/input", reqBody);
  }

  static Future loadHeatInfoById(id, peopleId) async {
    var resp = await HttpUtil.getRequest(baseUri + "/pfws/heat/id/$id");
    HeatInfo info;
    if(resp?.length != null) {
      print("LENGTH: ${resp.length}");
      info = new HeatInfo();
      info.id = resp["heatId"].toString();
      info.heat_number = resp["heatName"];
      info.heat_title = resp["heatDesc"];
      info.critiqueSheetType = 2;
      info.judge = peopleId;
      if(info.danceSubheatLevels == null) {
        info.danceSubheatLevels = [];
      }
      // traverse sub heats
      if(resp["subheats"] != null) {
        for(var sh in resp["subheats"]) {
          if(sh["entries"] != null) {
            for(var e in sh["entries"]) {
              if(e["peopleId"] != null && e["peopleId"] == int.parse(peopleId)) {
                // found entry
                if(info.assignedCouple == null)
                  info.assignedCouple = [];

                // get subheat Level
                info.danceSubheatLevels.add(sh["subHeatlevel"]);
                info.assignedCouple.add(e["entryKey"]);
              }
              if(e["entryId"] != null) {
                if(info.entries == null)
                  info.entries = [];

                info.entries.add(e["entryId"]);
              }
            }
          }
        }
      }
    }
    return info;
  }

  static Future loadJobPanelInfo() async {
    var resp = await HttpUtil.getRequest(baseUri + "/pfws/panel/info");
    if(resp?.length != null) {
      print("LENGTH: ${resp.length}");
      await PiContentDao.saveAllPanelInfo(resp);
      await PiContentDao.getAllPanelInfo();
    }
    return resp;
  }

  static Future loadPeople() async {
    var resp = await HttpUtil.getRequest(baseUri + "/pfws/people/info");
    print("LENGTH: ${resp.length}");
    for(var p in resp) {
      int peopleId = await PiContentDao.savePeople(p);
      for(var a in p["assignments"]) {
        /*String _role = "";
        switch(a["role"]) {
          case "JUDGE":
        }*/
        int assignmentId = await PiContentDao.saveAssignment(a, peopleId);
      }
    }
    return resp;
  }

  //static Future loadCouples(entryKey) async {
  static Future loadCouples() async {
    print("LOADING ALL COUPLES");
    //var c = await HttpUtil.getRequest(baseUri + "/pfws/heat/couple/key/${entryKey}");
    var resp = await HttpUtil.getRequest(baseUri + "/pfws/heat/couples");
    print("LENGTH: ${resp.length}");
    for(var c in resp) {
      //if(c != null && c["coupleId"] != null) {
        var couple_key = await PiContentDao.saveCouple(c);
        // save persons
        for(var p in c["persons"]) {
          await PiContentDao.savePerson(p, c["coupleKey"]);
        }
    }
    return resp;
  }

  static Future loadAllHeatsByPanelId(id) async {
    print("LOADING ALL HEATS in ID[${id}]");
    var resp = await HttpUtil.getRequest(baseUri + "/pfws/heat/panel/id/${id}");
    int heatCnt = 0;
    for(var h in resp["heats"]) {
      int subCnt = 0;
      int entryCnt = 0;
      await PiContentDao.saveHeat(h);
      heatCnt += 1;
      // save sub heats
      for(var s in h["subheats"]) {
        await PiContentDao.saveSubHeat(s);
        subCnt += 1;
        // save entries
        for(var e in s["entries"]) {
          await PiContentDao.saveEntry(e, s["subHeatId"], s["heatId"]);
          entryCnt += 1;
          //await loadCouples(e["entryKey"]);
        }
      }
      //print("SUB HEATS: [$subCnt]");
      //print("ENTRIES: [$entryCnt]");
    }
    print("HEATS: [$heatCnt]");
    //print("LENGTH: ${resp["heats"]?.length}");
  }

  static Future loadEventData() async {
    // load all job panel
    await cleanPiTables();
    var panels = await loadJobPanelInfo();
    for(var p in panels) {
      await loadAllHeatsByPanelId(p["jobPanelId"]);
    }
    await PiContentDao.getAllHeats();
    // load all couples
    await loadCouples();
    await PiContentDao.getAllCouples();
    await PiContentDao.getAllPersons();
    // load pi people
    await loadPeople();
    await PiContentDao.getAllPeople();
    await PiContentDao.getAllAssignments();
  }
}