import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:danceframe_et/model/config/DeviceConfig.dart';

///
/// Application-level global variable to access the WebSockets
///
WebSocketsNotifications sockets = new WebSocketsNotifications();

///
/// Put your WebSockets server IP address and port number
///
//const String _SERVER_ADDRESS1 = "ws://192.168.1.10:9441/ws/random";
//const String _SERVER_ADDRESS2 = "ws://localhost:9441/ws/random";
String _SERVER_ADDRESS1 = "http://0d78d8fb8bcc.ngrok.io";
String _SERVER_ADDRESS2 = "http://0d78d8fb8bcc.ngrok.io";
const String protocol = "ws://";
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
  String currentURI;
  String currentTopic = "/topic/message";
  String errorTopic = "/topic/error";
  String sendTopic = "/app/device";

  ///
  /// Listeners
  /// List of methods to be called when a new message
  /// comes in.
  ///
  ObserverList<Function> _listeners = new ObserverList<Function>();

  dynamic onConnect(StompClient client, StompFrame frame) {
    retryCount = 0;
    _isOn = true;
    print("@@ websocket connected: ${client.connected}");
    client.subscribe(
        destination: currentTopic,
        callback: (StompFrame frame) {
          var message = json.decode(frame.body);
          print(message);
          _onReceptionOfMessageFromServer(frame.body);
        }
    );

    client.subscribe(
        destination: errorTopic,
        callback: (StompFrame frame) {
          var message = json.decode(frame.body);
          print("ERROR MESSAGE");
          print(message);
          //_onReceptionOfMessageFromServer(frame.body);
        }
    );
  }

  onError(err) {
    print("server URI: $currentURI");
    print('websocket error ==> $err');
    stateConnectionLost = true;
    _channel = null;
    reconnect();
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

      _SERVER_ADDRESS1 = getPrimaryUri();
      _SERVER_ADDRESS1 = _SERVER_ADDRESS1.replaceAll("http://", "");
      _SERVER_ADDRESS1 = _SERVER_ADDRESS1.replaceAll("https://", "");
      _SERVER_ADDRESS1 = protocol + _SERVER_ADDRESS1 + path;

      _SERVER_ADDRESS2 = getSecondaryUri();
      _SERVER_ADDRESS2 = _SERVER_ADDRESS2.replaceAll("http://", "");
      _SERVER_ADDRESS2 = _SERVER_ADDRESS2.replaceAll("https://", "");
      _SERVER_ADDRESS2 = protocol + _SERVER_ADDRESS2 + path;

      if(currentURI == null || currentURI.isEmpty) {
        currentURI = _SERVER_ADDRESS1;
        print("Try connecting [$currentURI] . . . .");
      }
      //Preferences.getSharedValue("primaryRPI").then((primaryRPI){
        //Preferences.getSharedValue(primaryRPI).then((val1){

          //Preferences.getSharedValue(primaryRPI).then((val2){
            _channel = StompClient(
                config: StompConfig(
                    url: currentURI,
                    onConnect: onConnect,
                    reconnectDelay: 5,
                    connectionTimeout: Duration(seconds: 2),
                    stompConnectHeaders: {},
                    webSocketConnectHeaders: {},
                    onWebSocketError: onError,
                    //onWebSocketDone: onDone,
                    onWebSocketDone: (){
                      print("WEBSOCKET DONE");
                    },
                    onDisconnect: (frame){
                      print("DISCONNECTED....");
                    },
                    beforeConnect: (){
                      print("BEFORE CONNECT....");
                    }
                )
            );

            _channel.activate();
          //});
        //});
      //});
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

  getPrimaryUri() {
    if(DeviceConfig.primary == "rpi1"){
      return DeviceConfig.rpi1;
    } else {
      return DeviceConfig.rpi2;
    }
  }

  getSecondaryUri() {
    if(DeviceConfig.primary == "rpi1"){
      return DeviceConfig.rpi2;
    } else {
      return DeviceConfig.rpi1;
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
        _channel.send(destination: sendTopic, body: message, headers: {});
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