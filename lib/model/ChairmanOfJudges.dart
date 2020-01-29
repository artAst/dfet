import 'Person.dart';

class ChairmanOfJudges extends Person {

  final String tableName = "chairman_of_judges";

  ChairmanOfJudges();

  ChairmanOfJudges.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    first_name = map["first_name"];
    last_name = map["last_name"];
    gender = map["gender"];
  }
}