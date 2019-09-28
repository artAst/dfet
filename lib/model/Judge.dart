

class Judge {
  String id;
  String first_name;
  String last_name;
  String gender;
  List<String> initials;

  final String tableName = "judge";

  Judge({this.first_name, this.last_name, this.gender, this.initials});

  Judge.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    first_name = map["first_name"];
    last_name = map["last_name"];
    gender = map["gender"];
    initials = (map["initials"] as String).split("|");
  }

  Map<String, dynamic> toMap() {
    String _temp;
    if(initials.length > 0) {
      _temp = "";
      initials.forEach((v) => _temp += (_temp.isEmpty) ? v : "|"+v);
    }

    return {
      "id": id,
      "first_name": first_name,
      "last_name": last_name,
      "gender": gender,
      "initials": _temp
    };
  }
}