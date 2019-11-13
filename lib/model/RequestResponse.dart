

class RequestResponse {
  String action;
  int status_code;
  String message;

  RequestResponse({this.action, this.status_code, this.message});

  RequestResponse.fromMap(Map<String, dynamic> map) {
    action = map["action"];
    if(map["data"] != null) {
      status_code = map["data"]["status_code"];
      message = map["data"]["message"];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "action": action,
      "data": toDataMap()
    };
  }

  Map<String, dynamic> toDataMap() {
    return {
      "status_code": status_code,
      "message": message
    };
  }
}