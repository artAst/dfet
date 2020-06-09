import 'LoadContent.dart';
import 'package:intl/intl.dart';
import 'package:danceframe_et/dao/PiContentDao.dart';
import 'package:danceframe_et/dao/LocalContentDao.dart';
import 'package:danceframe_et/model/HeatData.dart';
import 'package:danceframe_et/mapper/HeatMapper.dart';
import 'package:danceframe_et/model/JobPanelData.dart';
import 'package:danceframe_et/mapper/JobPanelInfoMapper.dart';
import 'package:danceframe_et/mapper/SubHeatMapper.dart';
import 'package:danceframe_et/model/HeatCouple.dart';
import 'package:danceframe_et/mapper/EntryMapper.dart';
import 'package:danceframe_et/util/Preferences.dart';

class InitializationUtil {
  static var formatter = new DateFormat("yyyy-MM-dd HH:mm");

  static Future configureLocalData() async {
    print("CONFIGURING DATA");
    // truncate data
    await LocalContentDao.truncateDB();

    // load pi_panel_infos
    var panels = await PiContentDao.getAllPanelInfo();
    int panelCnt = 0;
    for(var p in panels) {
      // save job panel
      JobPanelData j = JobPanelInfoMapper.mapFromPanelInfo(p);
      j.panel_order = panelCnt++;
      print("${p["jobPanelDate"]} ${p["jobPanelTime"]}");
      j.time_start = formatter.parse("${p["jobPanelDate"]} ${p["jobPanelTime"]}");
      j.time_end = formatter.parse("${p["jobPanelDate"]} ${p["jobPanelTime"]}");
      await LocalContentDao.saveJobPanelData(j);
      // get job panel heats
      var pi_heats = await PiContentDao.getAllHeatsByPanelId(p["jobPanelId"]);
      int heatCnt = 0;
      int heatStart;
      int heatEnd;
      for(var h in pi_heats) {
        HeatData heatData = HeatMapper.mapFromPiHeat(h);
        if(heatCnt > 0) {
          heatStart = int.parse(heatData.id);
        }
        heatData.heat_order = heatCnt++;
        heatData.critique_sheet_type = 2;
        await LocalContentDao.saveHeat(heatData);
        // get all sub heats for particular heat id
        var pi_subheats = await PiContentDao.getAllSubHeatsByHeatId(heatData.id);
        for(var sh in pi_subheats) {
          SubHeatData shd = SubHeatMapper.mapFromPiSubHeat(sh);
          shd.heat_data_id = heatData.id;
          print("VAR SH: $sh");
          await LocalContentDao.saveSubHeat(shd);
          // load entries from subheat
          var pi_entries = await PiContentDao.getAllEntriesBySubHeatId(shd.id);
          print("VAR pi_entries: $pi_entries");
          for(var e in pi_entries) {
            // load couple entry
            var pi_couple = await PiContentDao.getCoupleByEntryKey(e["entryKey"]);
            print("pi_couple KEY ${pi_couple["coupleKey"]}");
            // load persons for couple
            var pi_persons = await PiContentDao.getPersonsByCoupleKey(pi_couple["coupleKey"]);
            String studio = "";
            HeatCouple hc = EntryMapper.mapFromPiEntry(pi_couple, e["subHeatId"], sh["subHeatLevel"], sh["subHeatAge"], studio);
            print("PI_PERSONS LENGTH: ${pi_persons.length}");
            for(var p in pi_persons) {
              CouplePerson cp = EntryMapper.mapFromPiPerson(p, sh["subHeatLevel"]);
              if(studio != "") {
                hc.participant2 = cp;
              }
              else {
                hc.participant1 = cp;
              }
              studio = p["studioName"];
              await LocalContentDao.saveCouplePerson(cp);
            }
            //print("HC MAP: ${hc.toMap()}");
            await LocalContentDao.saveHeatCouple(hc);
          }
        }
        heatEnd = int.parse(heatData.id);
      }

      if(heatStart != null && heatEnd != null) {
        j.heat_start = heatStart;
        j.heat_end = heatEnd;
      }
      await LocalContentDao.updateJobPanelData(j);
    }
  }

  static Future initData(context, Function f) async {
    // check if connection status ok
    // clear local pi tables
    // load content from pi
    await LoadContent.loadUriConfig(f);
    await LoadContent.loadEventConfig(context);
    await LoadContent.loadTimeoutConfig(context);
    String deviceNum = await Preferences.getSharedValue("deviceNumber");
    print("GETTING DEVICE NUMBER: $deviceNum");
    if(deviceNum != null && deviceNum.isNotEmpty) {
      //await LoadContent.loadDeviceConfig(context, deviceNum);
    }
    await LoadContent.loadEventData(context, f);
    // configure device data reflecting data from pi tables
    //await configureLocalData();
    //await LocalContentDao.selectHeatCouple(28);
  }
}