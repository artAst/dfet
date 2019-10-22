class Contact {
  String id;
  String full_name;
  String phone;
  String best_email;
  String to_email;
  String event_website;

  final String tableName = "contact_us";

  Contact({this.id, this.full_name, this.phone, this.best_email, this.to_email, this.event_website});

  Contact.fromMap(Map<String, dynamic> map) {
    id = map["id"].toString();
    full_name = map["full_name"];
    phone = map["phone"];
    best_email = map["best_email"];
    to_email = map["to_email"];
    event_website = map["event_website"];
  }

  Map<String, dynamic> toMap() {

    return {
      "id": id,
      "full_name": full_name,
      "phone": phone,
      "best_email": best_email,
      "to_email": to_email,
      "event_website": event_website
    };
  }
}