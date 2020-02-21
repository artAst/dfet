import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:danceframe_et/model/JobPanelData.dart';
import 'package:danceframe_et/model/PersonData.dart';
import 'package:danceframe_et/model/HeatData.dart';
import 'package:danceframe_et/model/HeatCouple.dart';

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

  static Future getAllJobPanelData() async {
    Database db = await DatabaseHelper.instance.database;
    List<JobPanelData> jobPanels = [];
    List<Map> result = await db.query(JobPanelData.tableName);
    for(Map row in result) {
      print(row);
      JobPanelData _data = new JobPanelData.fromMap(row);
      _data.panel_persons = await getPersonsByPanelId(_data.id);
      _data.heats = await getHeatDataByPanelId(_data.id);
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

  static Future getHeatDataByPanelId(String id) async {
    Database db = await DatabaseHelper.instance.database;
    List<HeatData> heats = [];
    List<Map> maps = await db.query(HeatData.tableName,
        where: 'job_panel_data_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      for(var itm in maps) {
        print(itm);
        HeatData h = new HeatData.fromMap(itm);
        h.sub_heats = await getSubHeatDataByHeatDataId(h.id);
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
        print(itm);
        SubHeatData h = new SubHeatData.fromMap(itm);
        h.couples = await getSubHeatCouplesBySubHeatId(h.id);
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
    if (maps.length > 0) {
      for(var itm in maps) {
        print(itm);
        HeatCouple c = new HeatCouple.fromMap(itm);
        c.participant1 = await getSubHeatParticipantById(itm["participant1"].toString());
        c.participant2 = await getSubHeatParticipantById(itm["participant2"].toString());
        couples.add(c);
      }
      return couples;
    }
    return null;
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
}