

class EntryData {
  String entryId;
  bool onDeck;
  bool onFloor;

  EntryData({this.entryId, this.onDeck, this.onFloor});

  EntryData.fromMap(Map<String, dynamic> map) {
    entryId = map["entryId"];
    onDeck = map["onDeck"] == "true" ? true : false;
    onFloor = map["onFloor"] == "true" ? true : false;
  }

  toMap() {
    return {
      "entryId": entryId,
      "onDeck": onDeck.toString(),
      "onFloor": onFloor.toString(),
    };
  }
}