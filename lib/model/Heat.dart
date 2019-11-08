import 'Judge.dart';

class HeatInfo {
  String id;
  String judge;
  String heat_number;
  String heat_title;
  List<String> assignedCouple;
  int critiqueSheetType; // type 1 = scoresheet // type 2 = components
  int heat_order;

  HeatInfo({this.judge, this.heat_number, this.heat_title, this.assignedCouple, this.critiqueSheetType, this.heat_order});

  HeatInfo.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    judge = map["judge_id"].toString();
    heat_number = map["heat_number"];
    heat_title = map["heat_title"];
    assignedCouple = (map["assigned_couple"] as String).split("|");
    critiqueSheetType = map["critique_sheet_type"];
    heat_order = map["heat_order"];
  }

  Map<String, dynamic> toMap() {
    String _temp;
    if(assignedCouple.length > 0) {
      _temp = "";
      assignedCouple.forEach((v) => _temp += (_temp.isEmpty) ? v : "|"+v);
    }

    return {
      "id": id,
      "judge_id": judge,
      "heat_number": heat_number,
      "heat_title": heat_title,
      "assigned_couple": _temp,
      "critique_sheet_type": critiqueSheetType,
      "heat_order": heat_order,
    };
  }
}

class HeatSocketData {
  String action;
  HeatInfo data;

  HeatSocketData({this.action, this.data});

  HeatSocketData.fromMap(Map<String, dynamic> map) {
    action = map["action"];
    if(map["data"] != null && map["data"].isNotEmpty) {
      data = new HeatInfo.fromMap(map["data"]);
    }
  }
}

class CritiqueData1 {
  String id;
  String technique;
  String musicality;
  String partnering_skill;
  String presentation;
  String feedback;

  CritiqueData1({this.technique, this.musicality, this.partnering_skill, this.presentation, this.feedback});

  CritiqueData1.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    technique = map["technique"];
    musicality = map["musicality"];
    partnering_skill = map["partnering_skill"];
    presentation = map["presentation"];
    feedback = map["feedback"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "technique": technique,
      "musicality": musicality,
      "partnering_skill": partnering_skill,
      "presentation": presentation,
      "feedback": feedback
    };
  }
}

class CritiqueData2 {
  String id;
  List<String> wl_technical_components;
  List<String> wl_artistic_components;
  List<String> ki_technical_components;
  List<String> ki_artistic_components;
  String feedback;

  CritiqueData2({this.wl_technical_components, this.wl_artistic_components, this.ki_technical_components, this.ki_artistic_components, this.feedback});

  CritiqueData2.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    wl_technical_components = map["wl_technical_components"];
    wl_artistic_components = map["wl_artistic_components"];
    ki_technical_components = map["ki_technical_components"];
    ki_artistic_components = map["ki_artistic_components"];
    feedback = map["ki_artistic_components"];
  }

  Map<String, dynamic> toMap() {
    String wl_tc_temp;
    String wl_ac_temp;
    String ki_tc_temp;
    String ki_ac_temp;
    if(wl_technical_components != null && wl_technical_components.length > 0) {
      wl_tc_temp = "";
      wl_technical_components.forEach((v) => wl_tc_temp += (wl_tc_temp.isEmpty) ? v : "|"+v);
    }
    if(wl_artistic_components != null && wl_artistic_components.length > 0) {
      wl_ac_temp = "";
      wl_artistic_components.forEach((v) => wl_ac_temp += (wl_ac_temp.isEmpty) ? v : "|"+v);
    }
    if(ki_technical_components != null && ki_technical_components.length > 0) {
      ki_tc_temp = "";
      ki_technical_components.forEach((v) => ki_tc_temp += (ki_tc_temp.isEmpty) ? v : "|"+v);
    }
    if(ki_artistic_components != null && ki_artistic_components.length > 0) {
      ki_ac_temp = "";
      ki_artistic_components.forEach((v) => ki_ac_temp += (ki_ac_temp.isEmpty) ? v : "|"+v);
    }

    return {
      "id": id,
      "wl_technical_components": wl_tc_temp,
      "wl_artistic_components": wl_ac_temp,
      "ki_technical_components": ki_tc_temp,
      "ki_artistic_components": ki_ac_temp,
      "feedback": feedback,
    };
  }
}