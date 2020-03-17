import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:danceframe_et/model/Person.dart';

class PersonDao {

  static Future getAllPersons() async {
    Database db = await DatabaseHelper.instance.database;
    List<Person> persons = [];
    List<Map> result = await db.query("person");
    for(Map row in result) {
      print(row);
      persons.add(new Person.fromMap(row));
    }
    return persons;
  }

  static Future getAllPersons_pi() async {
    Database db = await DatabaseHelper.instance.database;
    List<Person> persons = [];
    List<Map> result = await db.query("pi_people");
    for(Map row in result) {
      print(row);
      String fname = "";
      String lname = "";
      if(row["peopleName"] != null){
        List<String> _name = row["peopleName"].split(" ");
        if(_name.length > 0) {
          fname = _name[0];
          lname = _name[1];
        }
      }
      // get user roles
      String _roles;
      List<Map> res = await db.query("pi_assignment", where: 'peopleId = ?', whereArgs: [row["peopleId"]]);
      for(var a in res) {
        print("ROLE: ${a["role"]}");
        if(_roles == null) {
          _roles = a["role"];
        }
        else {
          _roles += "|${a["role"]}";
        }
      }
      print("_roles: ${_roles}");
      persons.add(new Person.fromMap({
        "id": row["peopleId"],
        "first_name": fname,
        "last_name": lname,
        "gender": "Male",
        "user_roles": _roles
      }));
    }
    return persons;
  }

  static Future getPersonByName(String firstname, String lastname) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> maps = await db.query("person",
//        columns: [columnId, columnWord, columnFrequency],
        where: 'UPPER(first_name) = UPPER(?) AND UPPER(last_name) = UPPER(?)',
        whereArgs: [firstname, lastname]);
    if (maps.length > 0) {
      print(maps.first);
      return Person.fromMap(maps.first);
    }
    return null;
  }

  static Future savePerson(Person p) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert("person", p.toMap());
    return id;
  }

  static Future updatePerson(Person p) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.update("person", p.toMap(),
        where: "id = ?", whereArgs: [p.id]);
    return id;
  }
}