import 'package:danceframe_et/model/JobPanel.dart';

class RoleMatrix {
  int id;
  String description;
  bool judge;
  bool scrutineer;
  bool emcee;
  bool chairman;
  bool deck;
  bool registrar;
  bool musicDj;
  bool photosVideo;
  bool hairMakeup;

  RoleMatrix({
    this.id, this.description, this.judge, this.scrutineer,
    this.emcee, this.chairman, this.deck, this.registrar,
    this.musicDj, this.photosVideo, this.hairMakeup
  });

  RoleMatrix.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    description = map["description"];
    judge = map["judge"];
    scrutineer = map["scrutineer"];
    emcee = map["emcee"];
    chairman = map["chairman"];
    deck = map["deck"];
    registrar = map["registrar"];
    musicDj = map["musicDj"];
    photosVideo = map["photosVideo"];
    hairMakeup = map["hairMakeup"];
  }

  toMap() {
    return {
      "id": id,
      "description": description,
      "judge": judge,
      "scrutineer": scrutineer,
      "emcee": emcee,
      "chairman": chairman,
      "deck": deck,
      "registrar": registrar,
      "musicDj": musicDj,
      "photosVideo": photosVideo,
      "hairMakeup": hairMakeup
    };
  }

  JobPanel toJobPanel() {
    return new JobPanel(
      id: id,
      description: description,
      judge: judge,
      scrutineer: scrutineer,
      emcee: emcee,
      chairman: chairman,
      deck: deck,
      registrar: registrar,
      musicDj: musicDj,
      photosVideo: photosVideo,
      hairMakeup: hairMakeup
    );
  }
}