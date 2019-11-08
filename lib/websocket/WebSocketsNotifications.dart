import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

///
/// Application-level global variable to access the WebSockets
///
WebSocketsNotifications sockets = new WebSocketsNotifications();

///
/// Put your WebSockets server IP address and port number
///
const String _SERVER_ADDRESS1 = "ws://192.168.1.10:9441/ws/random";
const String _SERVER_ADDRESS2 = "ws://localhost:9441/ws/random";
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
  IOWebSocketChannel _channel;

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

  ///
  /// Listeners
  /// List of methods to be called when a new message
  /// comes in.
  ///
  ObserverList<Function> _listeners = new ObserverList<Function>();

  /// ----------------------------------------------------------
  /// Initialization the WebSockets connection with the server
  /// ----------------------------------------------------------
  initCommunication() async {
    ///
    /// Just in case, close any previous communication
    ///
    reset();

    ///
    /// Open a new WebSocket communication
    ///
    try {
      _channel = await IOWebSocketChannel.connect(currentURI);
      ///
      /// Start listening to new notifications / messages
      ///
      _channel.stream.listen(
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
      );
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
      if (_channel.sink != null){
        _channel.sink.close();
        _isOn = false;
      }
    }
  }

  /// ---------------------------------------------------------
  /// Sends a message to the server
  /// ---------------------------------------------------------
  send(String message){
    if (_channel != null){
      if (_channel.sink != null && _isOn){
        _channel.sink.add(message);
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
    _isOn = true;
    _listeners.forEach((Function callback){
      callback(message);
    });
  }
}