import 'dart:io';
import 'package:danceframe_et/model/config/TimeOutConfig.dart';
import 'package:danceframe_et/util/ConfigUtil.dart';
import 'package:danceframe_et/util/HttpUtil.dart';
import 'package:danceframe_et/dao/PiContentDao.dart';
import 'package:danceframe_et/model/Heat.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/model/config/EventConfig.dart';
import 'package:danceframe_et/model/config/DeviceConfig.dart';

class LoadContent {
  static String baseUri;
  static String baseUri2;
  static String protocol = "https://";
  
  static loadUriConfig(Function f) async {
    //String confValue = await ConfigUtil.getConfig("app_local_server");
    String confValue = await Preferences.getSharedValue("rpi1");
    Function.apply(f, [0.05]);
    String confValue2 = await Preferences.getSharedValue("rpi2");
    Function.apply(f, [0.05]);
    // strip down http or https
    confValue = confValue.replaceAll("http://", "");
    confValue = confValue.replaceAll("https://", "");
    confValue2 = confValue2.replaceAll("http://", "");
    confValue2 = confValue2.replaceAll("https://", "");
    if(confValue != null) {
      baseUri = confValue;
    }
    if(confValue2 != null) {
      baseUri2 = confValue2;
    }
  }

  static loadEventConfig(context) async {
    var resp = await httpRequest("/uberPlatform/config/event/info", context);
    if(resp != null) {
      EventConfig conf = new EventConfig(resp["eventName"], "${resp["eventDate"]} ${resp["eventTime"]}", resp["screenTimeout"]);
      print("EVENT CONFIG EventName: ${EventConfig.eventName}");
      print("EVENT CONFIG EventDate: ${EventConfig.eventDate}");
      print("EVENT CONFIG EventYear: ${EventConfig.eventYear}");
      print("EVENT CONFIG EventTime: ${EventConfig.eventTime}");
    }
  }

  static loadDeviceConfig(context, deviceId) async {
    var resp = await httpRequest("/uberPlatform/device/info/$deviceId", context);
    if(resp != null) {
      DeviceConfig conf = new DeviceConfig();
      DeviceConfig.deviceNum = resp["deviceNo"];
      DeviceConfig.deviceIp = resp["deviceIp"];
      DeviceConfig.mask = resp["mask"];
      DeviceConfig.rpi1 = resp["rpi1"];
      DeviceConfig.rpi2 = resp["rpi2"];
      DeviceConfig.rpi1Enabled = resp["rpi1Enabled"].toString().toLowerCase() == 'true';
      DeviceConfig.rpi2Enabled = resp["rpi2Enabled"].toString().toLowerCase() == 'true';
      DeviceConfig.primary = resp["primary"];
    }
  }

  static loadTimeoutConfig(context) async {
    var resp = await httpRequest("/uberPlatform/config/timeouts", context);
    if(resp != null) {
      TimeOutConfig().list.clear();
      for (var i = 0; i < resp.length; i++) { 
        print(resp[i]["jobType"]); 
        //store 
        TimeOutConfig().list.add(
          {
            "jobType": resp[i]["jobType"],
            "timeoutVal": resp[i]["timeoutVal"].toString(),
            "enabled": resp[i]["enabled"],
          }
        );
      }
      print("EVENT CONFIG EventName: ${EventConfig.eventName}");
      print("EVENT CONFIG EventDate: ${EventConfig.eventDate}");
      print("EVENT CONFIG EventYear: ${EventConfig.eventYear}");
      print("EVENT CONFIG EventTime: ${EventConfig.eventTime}");
    }
  }

  static Future saveEventConfig(context) async {
    Map reqBody = EventConfig.toMap();
    print(protocol + baseUri + "/uberPlatform/config/event/input");
    var resp = await HttpUtil.postRequest(context, protocol + baseUri + "/uberPlatform/config/event/input", reqBody);
  }

  static Future<bool> saveTimeoutConfig(context) async {
    var reqBody = TimeOutConfig().toMap(); 
    if(protocol == null || baseUri == null){
      return false;
    }
    else{
      print(protocol + baseUri + "/uberPlatform/config/timeout/input");
      print(reqBody);
      await HttpUtil.postRequest(context, protocol + baseUri + "/uberPlatform/config/timeout/input", reqBody);
      return true;
    } 
  }
 

  static Future saveDeviceConfig(context) async {
    Map reqBody = DeviceConfig.toMap();
    var resp = await HttpUtil.postRequest(context, protocol + baseUri + "/uberPlatform/device/info/input", reqBody);
  }

  static Future httpRequest(String uri, context) async {
    print("REQUEST: ${protocol + baseUri + uri}");
    var resp = await HttpUtil.getRequest(protocol + baseUri + uri);
    print("RESPONSE: $resp");
    int retryCount = 0;
    bool isUri2 = false;
    bool invalidResponse = false;

    do {
      if(resp is List) {
        print("LIST OBJECT");
      }
      else {
        if(resp.containsKey("error")) {
          invalidResponse = true;
        }
      }

      if(invalidResponse) {
        if (retryCount < 5) {
          // error has occurred retry request
          if (!isUri2) {
            print("requesting uri: ${protocol + baseUri + uri}");
            resp = await HttpUtil.getRequest(protocol + baseUri + uri);
          } else {
            print("requesting uri2: ${protocol + baseUri2 + uri}");
            resp = await HttpUtil.getRequest(protocol + baseUri2 + uri);
          }
          retryCount += 1;
        }
        else {
          retryCount = 0;
          if (!isUri2) {
            isUri2 = true;
          }
          else {
            isUri2 = false;
            print("Could not connect to RPI. Exiting application");
            ScreenUtil.showMainFrameDialog(
              context,
              "Error Connecting",
              "Cannot connect to server. Exiting application"
            ).then((val) async {
              await Preferences.setSharedValue("deviceNumber", null);
              await Preferences.setSharedValue("rpi1", null);
              await Preferences.setSharedValue("rpi2", null);
              exit(0);
            });
            break;
          }
        }
      }
    } while(invalidResponse);

    return resp;
  }

  static Future cleanPiTables() async {
    return PiContentDao.truncateTables();
  }

  static Future sendCritique(context, Map<String, dynamic> reqBody) async {
    var resp = await HttpUtil.postRequest(context, protocol + baseUri + "/uberPlatform/critique/input", reqBody);
  }

  static Future uploadImg(context, file) async {
    var resp = await HttpUtil.uploadImage(context, protocol+ baseUri + "/uberPlatform/upload", file);
    // return image upload ID
    if(resp != null && resp["uploadId"] != null) {
      return resp["uploadId"];
    } else {
      return null;
    }
  }

  static Future saveJudgeInitials(context, Map<String, dynamic> reqBody) async {
    var resp = await HttpUtil.postRequest(context, protocol+ baseUri + "/uberPlatform/people/initials/input", reqBody);
  }

  static Future loadHeatInfoById(id, peopleId, context) async {
    //var resp = await HttpUtil.getRequest(protocol+ baseUri + "/uberPlatform/heat/id/$id");
    var resp = await httpRequest("/uberPlatform/heat/id/$id", context);
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

  static Future loadJobPanelInfo(context) async {
    //var resp = await HttpUtil.getRequest(protocol+ baseUri + "/uberPlatform/panel/info");
    var resp = await httpRequest("/uberPlatform/cache/panel/info", context);
    if(resp?.length != null) {
      print("LENGTH: ${resp.length}");
      await PiContentDao.saveAllPanelInfo(resp);
      await PiContentDao.getAllPanelInfo();
    }
    return resp;
  }

  static Future loadPeople(context) async {
    //var resp = await HttpUtil.getRequest(protocol+ baseUri + "/uberPlatform/people/info");
    var resp = await httpRequest("/uberPlatform/cache/people/info", context);
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
  static Future loadCouples(context) async {
    print("LOADING ALL COUPLES");
    //var c = await HttpUtil.getRequest(protocol+ baseUri + "/uberPlatform/heat/couple/key/${entryKey}");
    //var resp = await HttpUtil.getRequest(protocol+ baseUri + "/uberPlatform/heat/couples");
    var resp = await httpRequest("/uberPlatform/cache/heat/couples", context);
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

  static Future loadAllHeatsByPanelId(id, context) async {
    print("LOADING ALL HEATS in ID[${id}]");
    //var resp = await HttpUtil.getRequest(protocol+ baseUri + "/uberPlatform/heat/panel/id/${id}");
    var resp = await httpRequest("/uberPlatform/cache/panel/id/${id}", context);
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

  static Future loadEventData(context, Function f) async {
    // load all job panel
    double loadDivision = 0.6;
    await cleanPiTables();
    Function.apply(f, [0.05]);
    var panels = await loadJobPanelInfo(context);
    Function.apply(f, [0.05]);
    if(panels.length > 0) {
      loadDivision = 0.6 / panels.length;
    }
    for(var p in panels) {
      await loadAllHeatsByPanelId(p["jobPanelId"], context);
      Function.apply(f, [loadDivision]);
    }

    if(panels.length <= 0)
      Function.apply(f, [0.6]);
    //await PiContentDao.getAllHeats();
    // load all couples
    await loadCouples(context);
    Function.apply(f, [0.1]);
    //await PiContentDao.getAllCouples();
    await PiContentDao.getAllPersons();
    // load pi people
    await loadPeople(context);
    Function.apply(f, [0.1]);
    //await PiContentDao.getAllPeople();
    //await PiContentDao.getAllAssignments();
  }
}