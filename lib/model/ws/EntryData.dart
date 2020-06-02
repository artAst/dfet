import 'OnDeckFloor.dart';
import 'Scratch.dart';
import 'Started.dart';

class EntryData {
  OnDeckFloor onDeckFloor;
  Scratch scratch;
  Started started;

  EntryData({this.onDeckFloor, this.scratch, this.started});

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
    if(map["started"] != null) {
      started = new Started.fromMap(map["started"]);
    }
  }

  toMap() {
    return {
      "onDeckFloor": onDeckFloor?.toMap(),
      "scratch": scratch?.toMap(),
      "started": started?.toMap(),
    };
  }
}