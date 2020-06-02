
class Started {
  bool started;
  int heatId;

  Started({this.started, this.heatId});

  Started.fromMap(Map<String, dynamic> map) {
    if(map["started"] != null || map["started"] != "null") {
      started = map["started"];
    }
    if(map["heatId"] != null) {
      heatId = map["heatId"];
    }
  }

  toMap() {
    return {
      "started": started,
      "heatId": heatId,
    };
  }
}