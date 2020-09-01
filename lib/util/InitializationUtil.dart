import 'LoadContent.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
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
import 'package:danceframe_et/model/config/DeviceConfig.dart';
import 'package:danceframe_et/util/ProcessContent.dart';

class InitializationUtil {
  static var formatter = new DateFormat("yyyy-MM-dd HH:mm");
  static Stopwatch _watch = Stopwatch();

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

  static Future loadGlobal4Config(resp) async {
    /*var jobPanelList = await LoadContent.loadEventPermission(context);
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
    Global4Config global4config = new Global4Config(permissions: jobPanelList, rolePermissions: rolePermissions);*/
    ProcessContent.loadEventPermission(resp["roles"]);
  }

  static Future loadDeviceConfig() async {
    String deviceNum;
    String rpi1;
    String rpi2;
    String deviceIp;
    String mask;
    String primary;
    bool rpi1Enabled;
    bool rpi2Enabled;

    deviceNum = await Preferences.getSharedValue("deviceNumber");
    rpi1 = await Preferences.getSharedValue("rpi1");
    rpi2 = await Preferences.getSharedValue("rpi2");
    deviceIp = await Preferences.getSharedValue("deviceIp");
    mask = await Preferences.getSharedValue("mask");
    primary = await Preferences.getSharedValue("primaryRPI");
    String val = await Preferences.getSharedValue("enabledRPI");
    if(val != null && val.isNotEmpty) {
      List<String> _enabled = [];
      if(val.contains(",")) {
        _enabled = val.split(",");
      }
      else {
        _enabled.add(val);
      }
      if(_enabled.contains("rpi1")) {
        rpi1Enabled = true;
      }
      if(_enabled.contains("rpi2")) {
        rpi2Enabled = true;
      }
    }
    DeviceConfig deviceConfig = new DeviceConfig(
      deviceIp: deviceIp,
      deviceNum: deviceNum,
      mask: mask,
      primary: primary,
      rpi1: rpi1,
      rpi2: rpi2,
      rpi1Enabled: rpi1Enabled,
      rpi2Enabled: rpi2Enabled
    );
    print("DEVICE CONFIG SET: ${DeviceConfig.toMap()}");
  }

  static Future initData(context, Function f) async {
    // check if connection status ok
    // clear local pi tables
    // load content from pi
    _watch.reset();
    _watch.start();
    await LoadContent.loadUriConfig(f);
    _watch.stop();
    print("Elapsed time [loadUriConfig] ${_watch.elapsedMilliseconds}ms");
    var resp = await LoadContent.httpGetData(context, f);
    _watch.reset();
    _watch.start();
    await loadDeviceConfig();
    _watch.stop();
    print("Elapsed time [loadDeviceConfig] ${_watch.elapsedMilliseconds}ms");
    _watch.reset();
    _watch.start();
    var conn = await LoadContent.loadEventConfig(resp);
    _watch.stop();
    print("Elapsed time [loadEventConfig] ${_watch.elapsedMilliseconds}ms");
    if(conn != null) {
      if(conn == "connectionFailure") {
        return conn;
      }
    }
    _watch.reset();
    _watch.start();
    await loadGlobal4Config(resp);
    _watch.stop();
    print("Elapsed time [loadGlobal4Config] ${_watch.elapsedMilliseconds}ms");
    _watch.reset();
    _watch.start();
    await LoadContent.loadTimeoutConfig(resp);
    _watch.stop();
    print("Elapsed time [loadTimeoutConfig] ${_watch.elapsedMilliseconds}ms");
    //String deviceNum = await Preferences.getSharedValue("deviceNumber");
    //print("GETTING DEVICE NUMBER: $deviceNum");
    /*if(deviceNum != null && deviceNum.isNotEmpty) {
      //await LoadContent.loadDeviceConfig(context, deviceNum);
    }*/
    await LoadContent.loadEventData(resp, context, f);
    // configure device data reflecting data from pi tables
    //await configureLocalData();
    //await LocalContentDao.selectHeatCouple(28);
  }
}