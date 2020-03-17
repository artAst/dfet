import 'package:danceframe_et/model/HeatCouple.dart';

class EntryMapper {

  static HeatCouple mapFromPiEntry(piHeat, subHeatId, coupleLevel, ageCat, studio) {
    return HeatCouple.fromMap({
      "id": piHeat["coupleId"],
      "sub_heat_id": subHeatId,
      //"participant1": piHeat["heatName"],
      //"participant2": piHeat["heatDesc"],
      "couple_tag": piHeat["coupleKey"],
      "couple_level": coupleLevel,
      "age_category": ageCat,
      "studio": studio,
      "is_scratched": (piHeat["isScratched"] != null) ? piHeat["isScratched"] : false,
    });
  }

  static CouplePerson mapFromPiPerson(p, sLevel) {
    return CouplePerson.fromMap({
      "id": p["personId"],
      "first_name": p["firstName"],
      "last_name": p["lastName"],
      "gender": p["gender"],
      "age": 99,
      "level": sLevel
    });
  }
}