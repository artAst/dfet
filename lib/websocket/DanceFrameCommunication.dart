import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'StompClientNotifications.dart';

///
/// Again, application-level global variable
///
DanceFrameCommunication game = new DanceFrameCommunication();

class DanceFrameCommunication {
  static final DanceFrameCommunication _game = new DanceFrameCommunication._internal();

  ///
  /// At first initialization, the player has not yet provided any name
  ///
  String _playerName = "";

  ///
  /// Before the "join" action, the player has no unique ID
  ///
  String _playerID = "";

  factory DanceFrameCommunication(){
    return _game;
  }

  DanceFrameCommunication._internal(){
    print("INITIALIZE COMMUNICATION");
    ///
    /// Let's initialize the WebSockets communication
    ///
    sockets.initCommunication();

    ///
    /// and ask to be notified as soon as a message comes in
    ///
    sockets.addListener(_onMessageReceived);
  }

  ///
  /// Getter to return the player's name
  ///
  String get playerName => _playerName;

  void set playerId(id) {
    _playerID = id;
  }

  /// ----------------------------------------------------------
  /// Common handler for all received messages, from the server
  /// ----------------------------------------------------------
  _onMessageReceived(serverMessage){
    ///
    /// As messages are sent as a String
    /// let's deserialize it to get the corresponding
    /// JSON object
    ///
    print("MESSAGE from server: $serverMessage");
    Map message = json.decode(serverMessage);

    /*switch(message["action"]){
    ///
    /// When the communication is established, the server
    /// returns the unique identifier of the player.
    /// Let's record it
    ///
      case 'connect':
        _playerID = message["data"];
        break;

    ///
    /// For any other incoming message, we need to
    /// dispatch it to all the listeners
    ///
      default:
        _listeners.forEach((Function callback){
          callback(serverMessage);
        });
        break;
    }*/
    if(message["sendTo"] == "ALL" || message["sendTo"] == playerName) {
      _listeners.forEach((Function callback){
        callback(serverMessage);
      });
    }
  }

  /// ----------------------------------------------------------
  /// Common method to send requests to the server
  /// ----------------------------------------------------------
  send(jsonData){
    ///
    /// When a player joins, we need to record the name
    /// he provides
    ///
    /*if (action == 'join'){
      _playerName = data;
    }

    ///
    /// Send the action to the server
    /// To send the message, we need to serialize the JSON
    ///
    sockets.send(json.encode({
      "action": action,
      "data": data
    }));*/
    if(jsonData != null) {
      Map itm = {};
      itm.putIfAbsent("deviceId", () => _playerID);
      itm.addAll(jsonData);
      print("sending: $itm");
      sockets.send(json.encode(itm));
    }
  }

  /// ==========================================================
  ///
  /// Listeners to allow the different pages to be notified
  /// when messages come in
  ///
  ObserverList<Function> _listeners = new ObserverList<Function>();

  /// ---------------------------------------------------------
  /// Adds a callback to be invoked in case of incoming
  /// notification
  /// ---------------------------------------------------------
  addListener(Function callback){
    _listeners.add(callback);
  }
  removeListener(Function callback){
    _listeners.remove(callback);
  }
}