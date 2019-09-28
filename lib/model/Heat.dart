import 'Judge.dart';

class HeatInfo {
  String id;
  String judge;
  String heat_number;
  String heat_title;
  List<String> assignedCouple;
  int critiqueSheetType; // type 1 = scoresheet // type 2 = components

  HeatInfo({this.judge, this.heat_number, this.heat_title, this.assignedCouple, this.critiqueSheetType});

  HeatInfo.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    judge = map["judge_id"].toString();
    heat_number = map["heat_number"];
    heat_title = map["heat_title"];
    assignedCouple = (map["assigned_couple"] as String).split(",");
    critiqueSheetType = map["critique_sheet_type"];
  }

  Map<String, dynamic> toMap() {
    String _temp;
    if(assignedCouple.length > 0) {
      _temp = "";
      assignedCouple.forEach((v) => _temp += (_temp.isEmpty) ? v : "|"+v);
    }

    return {
      "id": id,
      "judge": judge,
      "heat_number": heat_number,
      "heat_title": heat_title,
      "assignedCouple": _temp,
      "critique_sheet_type": critiqueSheetType,
    };
  }
}

class HeatData {

}