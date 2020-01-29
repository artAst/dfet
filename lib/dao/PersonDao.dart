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