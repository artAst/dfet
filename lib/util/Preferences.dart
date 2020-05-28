import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future setSharedValue(String key, String sharedVal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, sharedVal);
    print("${key} SET: ${sharedVal}");
  }

  static Future getSharedValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sharedVal = prefs.getString(key);
    print("${key} GET: ${sharedVal}");
    return sharedVal;
  }

  static Future clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static Future clearSpecificPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}