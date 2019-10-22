import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:danceframe_et/model/Contact.dart';

class ContactDao {

  static Future saveContact(Contact c) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(c.tableName, c.toMap());
    return id;
  }
}