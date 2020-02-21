import 'HeatCouple.dart';
import 'package:intl/intl.dart';

final formatter = new DateFormat("yyyy-MM-dd HH:mm:ss");

class SubHeatData {
  String id;
  String sub_title;
  List<HeatCouple> couples;

  static final String tableName = "sub_heat_data";

  SubHeatData({
    this.sub_title,
    this.couples,
  });

  SubHeatData.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    sub_title = map["sub_title"];
    /*if(map["couples"] != null) {
      var _temp = map["couples"];
      couples = [];
      _temp.forEach((itm){
        couples.add(new HeatCouple.fromMap(itm));
      });
    }*/
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "sub_title": sub_title,
      "couples": couples?.map((val) => val.toMap())
    };
  }
}

class HeatData {
  String id;
  String heat_number; // should be the same as heat_order?
  String heat_title;
  DateTime time_start;
  List<SubHeatData> sub_heats;
  int critique_sheet_type; // type 1 = scoresheet // type 2 = components
  int heat_order;
  bool isStarted;

  static final String tableName = "heat_data";

  HeatData({
    this.heat_number,
    this.heat_title,
    this.sub_heats,
    this.critique_sheet_type,
    this.heat_order,
  });

  HeatData.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    heat_number = map["heat_number"];
    heat_title = map["heat_title"];
    if(map["time_start"] != null) {
      time_start = formatter.parse(map["time_start"]);
    }
    /*if(map["sub_heat"] != null) {
      sub_heat = new SubHeatData.fromMap(map["sub_heat"]);
    }*/
    critique_sheet_type = map["critique_sheet_type"];
    heat_order = map["heat_order"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "heat_number": heat_number,
      "heat_title": heat_title,
      "time_start": time_start!= null ? formatter.format(time_start) : formatter.format(new DateTime.now()),
      "sub_heats": sub_heats?.map((val) => val.toMap()),
      "critique_sheet_type": critique_sheet_type,
      "heat_order": heat_order,
    };
  }
}