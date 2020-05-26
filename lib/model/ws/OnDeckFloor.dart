
class OnDeckFloor {
  String entryId;
  bool onDeck;
  bool onFloor;

  OnDeckFloor({this.entryId, this.onDeck, this.onFloor});

  OnDeckFloor.fromMap(Map<String, dynamic> map) {
    entryId = map["entryId"].toString();
    onDeck = map["onDeck"];
    onFloor = map["onFloor"];
  }

  toMap() {
    return {
      "entryId": entryId,
      "onDeck": onDeck.toString(),
      "onFloor": onFloor.toString(),
    };
  }
}