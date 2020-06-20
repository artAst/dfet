import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:danceframe_et/model/JobPanelData.dart';
import 'package:danceframe_et/model/PersonData.dart';
import 'package:danceframe_et/model/HeatData.dart';
import 'package:danceframe_et/model/HeatCouple.dart';
import 'package:danceframe_et/model/Person.dart';

class JobPanelDataDao {

  static Future saveJobPanelData(JobPanelData j) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(JobPanelData.tableName, j.toMap());
    return id;
  }

  static Future updateHeatCouple(HeatCouple hc) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.update(HeatCouple.tableName, hc.saveMap(),
      where: 'id = ?',
      whereArgs: [hc.id],
    );
    return id;
  }

  static Future updateHeatCouple_pi(HeatCouple hc) async {
    Database db = await DatabaseHelper.instance.database;
    int stat = hc.is_scratched ? 2 : 1;
    int id = await db.rawUpdate("UPDATE pi_entry SET status = ? WHERE entryId = ?", [stat, hc.entry_id]);
    print("UPDATED HEAT COUPLE STATUS: ENTRYID[$id]");
    return id;
  }

  static Future getAllJobPanelData() async {
    Database db = await DatabaseHelper.instance.database;
    List<JobPanelData> jobPanels = [];
    List<Map> result = await db.query(JobPanelData.tableName);
    for(Map row in result) {
      print("JOB PANEL DATA: $row");
      JobPanelData _data = new JobPanelData.fromMap(row);
      _data.panel_persons = await getPersonsByPanelId(_data.id);
      _data.heats = await getHeatDataByPanelId(_data.id);
      jobPanels.add(_data);
    }
    return jobPanels;
  }

  static Future getAllJobPanelData_pi() async {
    Database db = await DatabaseHelper.instance.database;
    List<JobPanelData> jobPanels = [];
    List<Map> result = await db.query("pi_panel_info");
    for(Map row in result) {
      //print("pi_panel_info: $row");
      JobPanelData _data = new JobPanelData.fromPi(row);
      _data.panel_persons = await getPersonsByPanelId_pi(_data.id);
      _data.heats = await getHeatDataByPanelId_pi(_data.id);
      if(_data?.heats?.length > 0) {
        _data.heat_start = int.parse(_data.heats[0].id);
        _data.heat_end = int.parse(_data.heats[_data.heats.length - 1].id);
        _data.time_end = _data.heats[_data.heats.length - 1].time_start;
      }
      //print("TIMESTART: ${_data.time_start} PI JOBPANEL: ${_data.toMap()}");
      jobPanels.add(_data);
    }
    return jobPanels;
  }

  static Future getJobPanelDataById(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query(JobPanelData.tableName,
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      JobPanelData _data = new JobPanelData.fromMap(maps.first);
      _data.panel_persons = await getPersonsByPanelId(_data.id);
      _data.heats = await getHeatDataByPanelId(_data.id);
      return _data;
    }
    return null;
  }

  static Future getPersonsByPanelId(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<PersonData> persons = [];
    List<Map> maps = await db.query("person_data",
        where: 'job_panel_data_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      for(var itm in maps) {
        print(itm);
        PersonData p = new PersonData.fromMap(itm);
        persons.add(p);
      }
      return persons;
    }
    return null;
  }

  static Future getPersonsByPanelId_pi(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<PersonData> persons = [];
    List<Map> result = await db.query("pi_assignment", where: 'panelId = ?', whereArgs: [id]);
    for(Map row in result) {
      print(row);
      String fname = "";
      String lname = "";
      print("ROLE: ${row["role"]}");
      // get user roles
      String _role = row["role"];
      List<Map> res = await db.query("pi_people", where: 'peopleId = ?', whereArgs: [row["peopleId"]]);
      for(var a in res) {
        if(a["peopleName"] != null){
          List<String> _name = a["peopleName"].split(" ");
          if(_name.length > 0) {
            fname = _name[0];
            lname = _name[1];
          }
        }
        print("PEOPLE NAME: $fname $lname");
        persons.add(new PersonData.fromMap({
          "id": row["peopleId"],
          "first_name": fname,
          "last_name": lname,
          "gender": "Male",
          "user_roles": _role
        }));
      }
    }
    return persons;
  }

  static Future getHeatDataByPanelId(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<HeatData> heats = [];
    List<Map> maps = await db.query(HeatData.tableName,
        where: 'job_panel_data_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      for(var itm in maps) {
        print("HEAT DATA: $itm");
        HeatData h = new HeatData.fromMap(itm);
        h.sub_heats = await getSubHeatDataByHeatDataId(h.id);
        heats.add(h);
      }
      return heats;
    }
    return null;
  }

  static Future getHeatDataByPanelId_pi(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<HeatData> heats = [];
    List<Map> maps = await db.query("pi_heat",
        where: 'panelId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      for(var itm in maps) {
        //print("PI_HEAT DATA: $itm");
        HeatData h = new HeatData.fromPi(itm);
        h.sub_heats = await getSubHeatDataByHeatDataId_pi(h.id);
        h.isStarted = await getHeatStartValue("heat_started", int.parse(h.id));
        heats.add(h);
      }
      return heats;
    }
    return null;
  }

  static Future getSubHeatDataByHeatDataId(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<SubHeatData> subHeats = [];
    List<Map> maps = await db.query(SubHeatData.tableName,
        where: 'heat_data_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      for(var itm in maps) {
        print("SUB HEAT DATA: $itm");
        SubHeatData h = new SubHeatData.fromMap(itm);
        h.couples = await getSubHeatCouplesBySubHeatId(h.id);
        subHeats.add(h);
      }
      return subHeats;
    }
    return null;
  }

  static Future getSubHeatDataByHeatDataId_pi(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<SubHeatData> subHeats = [];
    List<Map> maps = await db.query("pi_sub_heat",
        where: 'heatId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      for(var itm in maps) {
        //print("PI_SUB_HEAT DATA: $itm");
        SubHeatData h = new SubHeatData.fromPi(itm);
        h.couples = await getSubHeatCouplesBySubHeatId_pi(h.id, itm["subHeatLevel"], itm["subHeatAge"]);
        subHeats.add(h);
      }
      return subHeats;
    }
    return null;
  }

  static Future getSubHeatCouplesBySubHeatId(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<HeatCouple> couples = [];
    List<Map> maps = await db.query(HeatCouple.tableName,
        where: 'sub_heat_id = ?',
        whereArgs: [id]);
    print("SELECT heat_couple where sub_heat_id = $id LENGTH[${maps.length}]");
    if (maps.length > 0) {
      for(var itm in maps) {
        print("HEAT COUPLE: $itm");
        HeatCouple c = new HeatCouple.fromMap(itm);
        c.participant1 = await getSubHeatParticipantById(itm["participant1"].toString());
        c.participant2 = await getSubHeatParticipantById(itm["participant2"].toString());
        couples.add(c);
      }
      return couples;
    }
    return null;
  }

  static Future getSubHeatCouplesBySubHeatId_pi(String id, subHeatLevel, subHeatAge) async {
    Database db = await DatabaseHelper.instance.database;
    List<HeatCouple> couples = [];

    List<Map> m_entry = await db.query("pi_entry",
        where: 'subHeatId = ?',
        whereArgs: [id]);
    var entry = m_entry.first;
    List<Map> maps = await db.query("pi_couple",
        where: 'coupleKey = ?',
        whereArgs: [entry["entryKey"]]);
    //print("SELECT heat_couple where subHeatId = $id LENGTH[${maps.length}]");
    if (maps.length > 0) {
      for(var itm in maps) {
        //print("PI HEAT COUPLE: $itm");
        HeatCouple c = new HeatCouple.fromPi(itm, id, subHeatLevel, subHeatAge);
        c.is_scratched = (entry["status"] != 1) ? true : false;
        c.entry_id = entry["entryId"].toString();
        c.studio = entry["studioName"];
        // query participants via coupleKey
        await getSubHeatParticipantById_pi(itm["coupleKey"], c);
        bool onDeck = await getOnFloorDeckValue("couple_on_deck", entry["entryId"]);
        bool onFloor = await getOnFloorDeckValue("couple_on_floor", entry["entryId"]);
        c.onDeck = onDeck;
        c.onFloor = onFloor;
        //print("HEATCOUPLE: ${c.toMap()}");
        couples.add(c);
      }
      return couples;
    }
    return null;
  }

  static Future getOnFloorDeckValue(tableName, id) async {
    var fd = await getOnFloorDeckByEntryId(tableName, id);
    bool retVal = (fd != null && fd["on_value"] == 1) ? true : false;
    return retVal;
  }

  static Future getHeatStartValue(tableName, id) async {
    var fd = await getStartedByHeatId(tableName, id);
    bool retVal = (fd != null && fd["is_started"] == 1) ? true : false;
    return retVal;
  }

  static Future getOnFloorDeckByEntryId(tableName, id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query(tableName,
        where: 'entry_id = ?',
        whereArgs: [id]);
    if(maps.length > 0) {
      return maps.first;
    }
    return null;
  }

  static Future getStartedByHeatId(tableName, id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query(tableName,
        where: 'heat_id = ?',
        whereArgs: [id]);
    if(maps.length > 0) {
      return maps.first;
    }
    return null;
  }

  static Future saveOnDeckFloor(tableName, entryId, val) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.rawInsert("INSERT OR REPLACE INTO $tableName VALUES(?, ?)", [entryId, val]);
    print("SAVED ONDECK/FLOOR: ENTRYID[$id]");
  }

  static Future saveHeatStarted(tableName, entryId, val) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.rawInsert("INSERT OR REPLACE INTO $tableName VALUES(?, ?)", [entryId, val]);
    print("SAVED HEAT START: HEAT_ID[$id] [${val == 1 ? true : false}]");
  }

  static Future getSubHeatParticipantById(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query(CouplePerson.tableName,
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return CouplePerson.fromMap(maps.first);
    }
    return null;
  }

  static Future getSubHeatParticipantById_pi(id, c) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query("pi_person",
        where: 'coupleKey = ?',
        whereArgs: [id]);
    //print("SELECT pi_person where coupleKey = $id LENGTH[${maps.length}]");
    if (maps.length > 0) {
      int cnt = 0;
      for(var p in maps) {
        if(cnt == 0) {
          c.participant1 = CouplePerson.fromPi(p);
        }
        else {
          c.participant2 = CouplePerson.fromPi(p);
        }
        cnt += 1;
      }
    }
    //print("participant1: ${c.participant1}");
    //print("participant2: ${c.participant2}");
  }
}