import 'package:danceframe_et/enums/ParticipantLevel.dart';

class CouplePerson {
  String id;
  String first_name;
  String last_name;
  String gender;
  ParticipantLevel level;
  int age;

  static final String tableName = "couple_person";

  CouplePerson({
    this.first_name,
    this.last_name,
    this.gender,
    this.level,
    this.age
  });

  CouplePerson.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    first_name = map["first_name"];
    last_name = map["last_name"];
    gender = map["gender"];
    if(map["level"] != null) {
      level = getParticipantLevelromString(map["level"]);
    }
    age = map["age"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "first_name": first_name,
      "last_name": last_name,
      "gender": gender,
      "level": level?.toString()?.replaceAll("ParticipantLevel.", ""),
      "age": age,
    };
  }
}

class HeatCouple {
  String id; // entry ID
  String sub_heat_id; // parent sub heat
  CouplePerson participant1;
  CouplePerson participant2;
  String couple_tag; // L-B1
  String couple_level;
  String age_category;
  String studio;
  bool onDeck;
  bool onFloor;
  bool is_scratched;

  static final String tableName = "heat_couple";

  HeatCouple({
    this.participant1,
    this.participant2,
    this.couple_tag,
    this.couple_level,
    this.age_category,
    this.studio,
  });

  HeatCouple.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    sub_heat_id = map["sub_heat_id"].toString();
    //participant1 = new CouplePerson.fromMap(map["participant1"]);
    //participant2 = new CouplePerson.fromMap(map["participant2"]);
    couple_tag = map["couple_tag"];
    couple_level = map["couple_level"];
    age_category = map["age_category"];
    studio = map["studio"];
    is_scratched = (map["is_scratched"] == 1) ? true : false;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "sub_heat_id": sub_heat_id,
      "participant1": participant1?.toMap(),
      "participant2": participant2?.toMap(),
      "couple_tag": couple_tag,
      "couple_level": couple_level,
      "age_category": age_category,
      "studio": studio,
      "is_scratched": is_scratched,
    };
  }

  Map<String, dynamic> saveMap() {
    return {
      "id": id,
      "sub_heat_id": sub_heat_id,
      "participant1": participant1?.id,
      "participant2": participant2?.id,
      "couple_tag": couple_tag,
      "couple_level": couple_level,
      "age_category": age_category,
      "studio": studio,
      "is_scratched": is_scratched ? 1 : 0,
    };
  }
}