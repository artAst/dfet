import 'Person.dart';

class Emcee extends Person{

  final String tableName = "emcee";

  Emcee();

  Emcee.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    first_name = map["first_name"];
    last_name = map["last_name"];
    gender = map["gender"];
  }
}