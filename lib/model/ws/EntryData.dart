import 'OnDeckFloor.dart';
import 'Scratch.dart';
import 'Started.dart';
import 'Summary.dart';
import 'RoleMatrix.dart';

class EntryData {
  OnDeckFloor onDeckFloor;
  Scratch scratch;
  Started started;
  RoleMatrix roleMatrix;
  List<Summary> summary;

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
    if(map["summary"] != null && map["summary"].length > 0) {
      var _summary = map["summary"];
      summary = [];
      for(var s in _summary) {
        summary.add(new Summary.fromMap(s));
      }
    }
    if(map["roleMatrix"] != null && map["roleMatrix"]["rolematrix"] != null) {
      roleMatrix = new RoleMatrix.fromMap(map["roleMatrix"]["rolematrix"]);
    }
  }

  toMap() {
    return {
      "onDeckFloor": onDeckFloor?.toMap(),
      "scratch": scratch?.toMap(),
      "started": started?.toMap(),
      "summary": summary?.map((s) => s?.toMap()),
    };
  }
}