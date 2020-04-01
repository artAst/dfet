import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:danceframe_et/util/Preferences.dart';

///
/// Application-level global variable to access the WebSockets
///
WebSocketsNotifications sockets = new WebSocketsNotifications();

///
/// Put your WebSockets server IP address and port number
///
//const String _SERVER_ADDRESS1 = "ws://192.168.1.10:9441/ws/random";
//const String _SERVER_ADDRESS2 = "ws://localhost:9441/ws/random";
String _SERVER_ADDRESS1 = "wss://7c015bf1.ngrok.io/uberPlatform/device";
String _SERVER_ADDRESS2 = "wss://echo.websocket.org";
const String protocol = "wss://";
const String path = "/uberPlatform/device";
const int retryMax = 5;

class WebSocketsNotifications {
  static final WebSocketsNotifications _sockets = new WebSocketsNotifications._internal();

  factory WebSocketsNotifications(){
    return _sockets;
  }

  WebSocketsNotifications._internal();

  ///
  /// The WebSocket "open" channel
  ///
  StompClient _channel;

  ///
  /// Is the connection established?
  ///
  bool _isOn = false;
  bool stateConnectionLost = false;

  // timer
  int wsDelaySeconds = 10;

  // retry count
  int retryCount = 0;

  // current server URL
  String currentURI = _SERVER_ADDRESS1;
  String currentTopic = "/topic/status";

  ///
  /// Listeners
  /// List of methods to be called when a new message
  /// comes in.
  ///
  ObserverList<Function> _listeners = new ObserverList<Function>();

  dynamic onConnect(StompClient client, StompFrame frame) {
    retryCount = 0;
    _isOn = true;
    print("@@ websocket connected");
    client.subscribe(
        destination: currentTopic,
        callback: (StompFrame frame) {
          var message = json.decode(frame.body);
          print(message);
          _onReceptionOfMessageFromServer(frame.body);
        });
  }

  onError(err) {
    print("server URI: $currentURI");
    print('websocket error ==> $err');
  }

  onDone() {
    print('@@ websocket channel closed');
    stateConnectionLost = true;
    _channel = null;
    reconnect();
  }

  /// ----------------------------------------------------------
  /// Initialization the WebSockets connection with the server
  /// ----------------------------------------------------------
  initCommunication() async {
    ///
    /// Just in case, close any previous communication
    ///
    print("reset().....");
    reset();

    ///
    /// Open a new WebSocket communication
    ///
    try {
      print("Try connecting [$currentURI] . . . .");

      Preferences.getSharedValue("rpi1").then((val1){
        _SERVER_ADDRESS1 = val1;
        _SERVER_ADDRESS1 = _SERVER_ADDRESS1.replaceAll("http://", "");
        _SERVER_ADDRESS1 = _SERVER_ADDRESS1.replaceAll("https://", "");
        _SERVER_ADDRESS1 = protocol + _SERVER_ADDRESS1 + path;
        currentURI = _SERVER_ADDRESS1;
        Preferences.getSharedValue("rpi1").then((val2){
          _SERVER_ADDRESS2 = val2;
          _SERVER_ADDRESS2 = _SERVER_ADDRESS2.replaceAll("http://", "");
          _SERVER_ADDRESS2 = _SERVER_ADDRESS2.replaceAll("https://", "");
          _SERVER_ADDRESS2 = protocol + _SERVER_ADDRESS2 + path;
          _channel = StompClient(
              config: StompConfig(
                  url: currentURI,
                  onConnect: onConnect,
                  reconnectDelay: 0,
                  connectionTimeout: Duration(seconds: wsDelaySeconds),
                  stompConnectHeaders: {},
                  webSocketConnectHeaders: {},
                  onWebSocketError: onError,
                  onWebSocketDone: onDone
              )
          );

          _channel.activate();
        });
      });
      ///
      /// Start listening to new notifications / messages
      ///
      /*_channel.stream.listen(
        (message){
          retryCount = 0;
          print("@@ websocket connected");
          _onReceptionOfMessageFromServer(message);
        },
        onError: (e) {
          print("server URI: $currentURI");
          print('websocket error ==> $e');
        },
        onDone: () {
          print('@@ websocket channel closed');
          stateConnectionLost = true;
          _channel = null;
          reconnect();
        },
      );*/

    } catch(e){
      /// General error handling
      /// TODO
      print("ERROR needs to be handled with connection.");
      print(e);
      _isOn = false;
    }
  }

  reconnect() {
    if(retryCount < 5) {
      retryCount += 1;
      print('@@ waiting for $wsDelaySeconds seconds');
      createTimer();
    } else {
      changeServer();
    }
  }

  createTimer() {
    Timer.periodic(
        Duration(seconds: wsDelaySeconds), (Timer timer) async {
      try {
        print("@@ retrying ...");
        await initCommunication();
      } catch (e) {
        print("@@ error: $e");
      }
      if (_channel != null) timer.cancel();
    });
  }

  changeServer() {
    print("=== Number of retries reached ===");
    print("Changing connection URI...");
    if(currentURI == _SERVER_ADDRESS1) {
      currentURI = _SERVER_ADDRESS2;
    } else {
      currentURI = _SERVER_ADDRESS1;
    }
    print('@@ connecting to $currentURI');
    retryCount = 0;
    createTimer();
  }

  /// ----------------------------------------------------------
  /// Closes the WebSocket communication
  /// ----------------------------------------------------------
  reset(){
    if (_channel != null){
      _channel.deactivate();
      _isOn = false;
    }
  }

  /// ---------------------------------------------------------
  /// Sends a message to the server
  /// ---------------------------------------------------------
  send(message){
    if (_channel != null){
      if (_isOn){
        _channel.send(destination: currentTopic, body: message, headers: {});
      }
    }
  }

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

  /// ----------------------------------------------------------
  /// Callback which is invoked each time that we are receiving
  /// a message from the server
  /// ----------------------------------------------------------
  _onReceptionOfMessageFromServer(message){
    _listeners.forEach((Function callback){
      callback(message);
    });
  }
}