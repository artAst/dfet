import 'OnDeckFloor.dart';
import 'Scratch.dart';

class EntryData {
  OnDeckFloor onDeckFloor;
  Scratch scratch;

  EntryData({this.onDeckFloor, this.scratch});

  EntryData.fromMap(Map<String, dynamic> map) {
    if(map["onDeckFloor"] != null) {
      onDeckFloor = new OnDeckFloor.fromMap(map["onDeckFloor"]);
    }
    if(map["ondeckfloor"] != null) {
      onDeckFloor = new OnDeckFloor.fromMap(map["ondeckfloor"]);
    }
    if(map["scratch"] != null) {
      scratch = new Scratch.fromMap(map["scratch"]);
    }
  }

  toMap() {
    return {
      "onDeckFloor": onDeckFloor?.toMap(),
      "scratch": scratch?.toMap()
    };
  }
}