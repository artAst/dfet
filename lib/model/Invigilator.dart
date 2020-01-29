import 'Person.dart';

class Invigilator extends Person {

  final String tableName = "invigilator";

  Invigilator();

  Invigilator.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    first_name = map["first_name"];
    last_name = map["last_name"];
    gender = map["gender"];
  }
}