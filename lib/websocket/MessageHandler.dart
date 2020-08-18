import 'dart:convert';
import 'package:danceframe_et/model/ws/EntryData.dart';
import 'package:danceframe_et/model/JobPanel.dart';
import 'package:danceframe_et/dao/JobPanelDataDao.dart';
import 'package:danceframe_et/model/config/Global4Config.dart';

class MessageHandler {

  static EntryData onMessageRecieveHandler(message) {
    print("message from widget: $message");
    // convert message to object
    EntryData e = EntryData.fromMap(jsonDecode(message));
    print("entrydata: ${e.toMap()}");

    if(e.onDeckFloor != null) {
      // on deck floor operation
      //_updateEntryFromJobPanels(e.onDeckFloor.entryId, e.onDeckFloor, e.summary, "onDeckFloor");
      // update local DB via entry ID
      JobPanelDataDao.saveOnDeckFloor("couple_on_deck", e.onDeckFloor.entryId, (e.onDeckFloor.onDeck ? 1 : 0));
      JobPanelDataDao.saveOnDeckFloor("couple_on_floor", e.onDeckFloor.entryId, (e.onDeckFloor.onFloor ? 1 : 0));
    }
    else if(e.scratch != null) {
      // scratch operation
      if(e.scratch.entries != null) {
        for (var s in e.scratch?.entries) {
          //String operation = "scratch";
          if (e.scratch.status == 1) {
            //operation = "unscratch";
          }
          JobPanelDataDao.saveScratchUnscratch(s, e.scratch.status);
          //_updateEntryFromJobPanels(s.toString(), s, e.summary, operation);
        }
      }
    }
    else if(e.started != null) {
      //_updateEntryFromJobPanels(e.started.heatId.toString(), e.started, e.summary, "started");
      JobPanelDataDao.saveHeatStarted("heat_started", e.started.heatId, (e.started.started ? 1 : 0));
    }
    else if(e.roleMatrix != null) {
      print("ROLEMATRIX: ${e.roleMatrix.toMap()}");
      JobPanel roleMatrix = e.roleMatrix.toJobPanel();
      for(JobPanel jp in Global4Config.permissions) {
        if(jp.id == roleMatrix.id) {
          jp = roleMatrix;
          break;
        }
      }
    }

    return e;
  }
}