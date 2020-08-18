import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/CPCheckbox.dart';
import 'package:danceframe_et/widgets/CPRadio.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/LoadingIndicator.dart';
import 'package:danceframe_et/model/config/DeviceConfig.dart';
import 'package:danceframe_et/util/DatabaseHelper.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/util/LoadContent.dart';
import 'package:device_info/device_info.dart';

class Device1ControlPanel extends StatefulWidget {
  @override
  _Device1ControlPanelState createState() => new _Device1ControlPanelState();
}

class _Device1ControlPanelState extends State<Device1ControlPanel> {
  TextEditingController deviceNum = new TextEditingController();
  TextEditingController rpi1 = new TextEditingController();
  TextEditingController rpi2 = new TextEditingController();
  TextEditingController deviceIp = new TextEditingController();
  TextEditingController mask = new TextEditingController();

  bool isNew = false;
  List<String> _enabled = [];
  String _primary = "";
  String rpi1_origin;
  String rpi2_origin;

  String testConnectText1 = "TEST CONNECTION";
  String testConnectText2 = "TEST CONNECTION";
  String connectStatus1 = "";
  Color connectStatusColor1 = Color(0xff2f4c5d);
  String connectStatus2 = "";
  Color connectStatusColor2 = Color(0xff2f4c5d);
  double widthInputs = 260.0;

  Stopwatch watch = Stopwatch();

  List<String> deviceInfo = [];
  String deviceId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDeviceDetails().then((value) {
      print("val: ${value.toString()}");
      setState(() {
        deviceInfo.addAll(value);
        deviceId = deviceInfo[2];
      });
    });

    Preferences.getSharedValue("deviceNumber").then((val){
      deviceNum.text = val;
      // check if init setup
      if(val == null) {
        isNew = true;
      }
    });
    Preferences.getSharedValue("rpi1").then((val){
      rpi1.text = val;
      rpi1_origin = val;
    });
    Preferences.getSharedValue("rpi2").then((val){
      rpi2.text = val;
      rpi2_origin = val;
    });
    Preferences.getSharedValue("deviceIp").then((val){
      deviceIp.text = val;
    });
    Preferences.getSharedValue("mask").then((val){
      mask.text = val;
    });
    Preferences.getSharedValue("primaryRPI").then((val){
      setState(() {
        _primary = val;
      });
    });
    Preferences.getSharedValue("enabledRPI").then((val){
      setState(() {
        if(val != null && val.isNotEmpty) {
          if(val.contains(",")) {
            _enabled = val.split(",");
          }
          else {
            _enabled.add(val);
          }
          print("enabled length: ${_enabled?.length} items: ${_enabled?.toString()}");
        }
      });
    });
  }

  LinearGradient gradientColor(){
    return new LinearGradient(
      colors: [new Color(0xff769AAB), new Color(0xffADC7D6), new Color(0xffADC7D6), new Color(0xff6890A2)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0,0.3,0.3,1.0]
    );
  }

  Widget connectButton(onPressed) => InkWell(
    onTap: onPressed,
    child: Container(
      decoration: new BoxDecoration(
          gradient: gradientColor(),
          borderRadius: new BorderRadius.all(new Radius.circular(8.0))
      ),
      width: 260.0,
      height: 40.0,
      alignment: Alignment.center,
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: "",
                    style: TextStyle(
                        fontSize: 12.0,
                        letterSpacing: 1.0
                    )
                ),
                TextSpan(
                    text: "TEST CONNECTION",
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1F333C),
                        letterSpacing: 1.0
                    )
                )
              ]
          )
      ),
    )
  );

  static Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId;  //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor;  //UUID for iOS
      }
    } catch(e) {
      print('Failed to get platform version');
    }

    return [deviceName, deviceVersion, identifier];
  }

  bool hasChangedRPI() {
    bool hasChangedRPI = false;
    print("rpi1_origin: $rpi1_origin === rpi1: ${rpi1.text}");
    print("rpi2_origin: $rpi2_origin === rpi2: ${rpi2.text}");
    if(rpi1_origin != rpi1.text) {
      hasChangedRPI = true;
    }
    if(rpi2_origin != rpi2.text) {
      hasChangedRPI = true;
    }
    return hasChangedRPI;
  }

  _discardDevice() async {
    setState(() {
      deviceNum.text = DeviceConfig.deviceNum;
      rpi1.text = DeviceConfig.rpi1;
      rpi2.text = DeviceConfig.rpi2;
      deviceIp.text = DeviceConfig.deviceIp;
      mask.text = DeviceConfig.mask;
      _primary = DeviceConfig.primary;
      _enabled = [];
      if(DeviceConfig.rpi1Enabled) {
        _enabled.add("rpi1");
      }
      if(DeviceConfig.rpi2Enabled) {
        _enabled.add("rpi2");
      }
    });

    ScreenUtil.showMainFrameDialog(context, "Changes Discarded", "");
  }

  void _saveDevice() {
    bool isError = false;
    if(deviceNum.text.isNotEmpty) {
      MainFrameLoadingIndicator.showLoading(context);
      print("saving device #${deviceNum.text}");
      Preferences.setSharedValue("deviceNumber", deviceNum.text);
      DeviceConfig.deviceNum = deviceNum.text;
      if(deviceIp.text.isNotEmpty) {
        Preferences.setSharedValue("deviceIp", deviceIp.text);
        DeviceConfig.deviceIp = deviceIp.text;
      }
      if(mask.text.isNotEmpty) {
        Preferences.setSharedValue("mask", mask.text);
        DeviceConfig.mask = mask.text;
      }
      if(_enabled != null && _enabled.isNotEmpty) {
        print("saving enabled: ${_enabled.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "")}");
        Preferences.setSharedValue("enabledRPI", _enabled.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ", ""));
        for(String e in _enabled) {
          if(e == "rpi1") {
            DeviceConfig.rpi1Enabled = true;
          }
          if(e == "rpi2") {
            DeviceConfig.rpi2Enabled = true;
          }
        }
      }
      if(_primary != null && _primary.isNotEmpty) {
        print("saving primary: ${_primary}");
        Preferences.setSharedValue("primaryRPI", _primary);
        DeviceConfig.primary = _primary;
      }
      else {
        isError = true;
        MainFrameLoadingIndicator.hideLoading(context);
        ScreenUtil.showMainFrameDialog(context, "Invalid", "Please Select a Primary RPI Link.");
      }
      if(rpi1.text.isNotEmpty) {
        if(_validateUri(rpi1.text)) {
          print("saving rpi1 #${rpi1.text}");
          Preferences.setSharedValue("rpi1", rpi1.text);
          DeviceConfig.rpi1 = rpi1.text;
          print(rpi2.text.isNotEmpty);
          if (rpi2.text.isNotEmpty) {
            if(_validateUri(rpi2.text)) {
              print("saving rpi2 #${rpi2.text}");
              Preferences.setSharedValue("rpi2", rpi2.text);
              DeviceConfig.rpi2 = rpi2.text;
            }
            else {
              isError = true;
              MainFrameLoadingIndicator.hideLoading(context);
              ScreenUtil.showMainFrameDialog(context, "Invalid", "Please input a valid URL in Raspbery Pi #2");
            }
          }
          else {
            isError = true;
            MainFrameLoadingIndicator.hideLoading(context);
            ScreenUtil.showMainFrameDialog(
                context, "Invalid", "Please Fill in Raspbery Pi #2");
          }
        } else {
          isError = true;
          MainFrameLoadingIndicator.hideLoading(context);
          ScreenUtil.showMainFrameDialog(context, "Invalid", "Please input a valid URL in Raspbery Pi #1");
        }
      }
      else {
        isError = true;
        MainFrameLoadingIndicator.hideLoading(context);
        ScreenUtil.showMainFrameDialog(context, "Invalid", "Please Fill in Raspbery Pi #1");
      }
    } else {
      isError = true;
      ScreenUtil.showMainFrameDialog(context, "Invalid", "Please Fill in Device Number");
    }

    if(!isError) {
      LoadContent.baseUri = rpi1.text;
      LoadContent.saveDeviceConfig(context).then((val) {
        MainFrameLoadingIndicator.hideLoading(context);
        ScreenUtil.showMainFrameDialog(
            context, "Saved", "Details saved.")
            .then((val) {
          /*if (isNew) {
            // Navigator.pushNamed(context, "/");
          } else {
            //Navigator.maybePop(context, true);
            //Navigator.pop(context);
            // Navigator.pushNamed(context, "/");
          }
          }*/
          setState(() {
            Preferences.setSharedValue("deviceNumber", deviceNum.text);
          });
          //Navigator.pushReplacementNamed(context, "/controlPanel");
        });
      });
    }
  }

  bool _validateUri(String url) {
    var regex = new RegExp("^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?").hasMatch(url);
    var without_regex = new RegExp("^([0-9A-Za-z-\\.@:%_\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?").hasMatch(url);
    bool hasMatch = regex || without_regex;
    print("link: $url is ${hasMatch ? "valid" : "invalid"}");
    return hasMatch;
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  void testConnection(String uri, bool isRPI1) {
    watch.reset();
    watch.start();
    //MainFrameLoadingIndicator.showLoading(context);
    setState(() {
      if(isRPI1) {
        connectStatus1 = "Connecting...";
        connectStatusColor1 = Color(0xff2f4c5d);
      } else {
        connectStatus2 = "Connecting...";
        connectStatusColor2 = Color(0xff2f4c5d);
      }
    });

    LoadContent.testConnection(context, uri+"/uberPlatform/test").then((value) {
      watch.stop();
      var timeSoFar = watch.elapsedMilliseconds;
      //MainFrameLoadingIndicator.hideLoading(context);
      print("RESPONSE: $value");
      //print("ELAPSED TIME: $timeSoFar transform: ${transformMilliSeconds(timeSoFar)}");
      if(value == null) {
        //ScreenUtil.showMainFrameDialog(context, "Test Connection Failed", "Failed to connect: $uri");
        setState(() {
          if(isRPI1) {
            //testConnectText1 = "CONNECT";
            connectStatus1 = "No Connection.";
            connectStatusColor1 = Colors.red;
          }
          else {
            //testConnectText2 = "CONNECT";
            connectStatus2 = "No Connection.";
            connectStatusColor2 = Colors.red;
          }
        });
      } else {
        //ScreenUtil.showMainFrameDialog(context, "Test Connection Success", "Success");
        setState(() {
          if(isRPI1) {
            //testConnectText1 = "CONNECTED ($timeSoFar)MS";
            connectStatus1 = "Connected: ${timeSoFar}ms";
            connectStatusColor1 = Colors.green;
          }
          else {
            //testConnectText2 = "CONNECTED ($timeSoFar)MS";
            connectStatus2 = "Connected: ${timeSoFar}ms";
            connectStatusColor2 = Colors.green;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FractionColumnWidth(0.25),
                1: FractionColumnWidth(0.75),
              },
              children: [
                TableRow(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 10.0),
                          alignment: Alignment.centerRight,
                          child: Text("Device UID: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700))
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(deviceId, style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w500)),
                        ],
                      )
                    ]
                ),
                TableRow(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 25.0)),
                      SizedBox()
                    ]
                ),
                TableRow(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 10.0),
                          alignment: Alignment.centerRight,
                          child: Text("Device number: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700))
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: widthInputs,
                            child: TextFormField(
                              decoration: new InputDecoration(
                                labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(fontSize: 24.0),
                              controller: deviceNum,
                            ),
                          )
                        ],
                      )
                    ]
                ),
                TableRow(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 25.0)),
                      SizedBox()
                    ]
                ),
                TableRow(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 10.0),
                          alignment: Alignment.centerRight,
                          child: Text("Device IP: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700))
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: widthInputs,
                            child: TextFormField(
                              decoration: new InputDecoration(
                                labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(fontSize: 24.0),
                              controller: deviceIp,
                            ),
                          )
                        ],
                      )
                    ]
                ),
                TableRow(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 25.0)),
                      SizedBox()
                    ]
                ),
                TableRow(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 10.0),
                          alignment: Alignment.centerRight,
                          child: Text("Mask: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700))
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: widthInputs,
                            child: TextFormField(
                              decoration: new InputDecoration(
                                labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(fontSize: 24.0),
                              controller: mask,
                            ),
                          )
                        ],
                      )
                    ]
                ),
                TableRow(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 25.0)),
                      SizedBox()
                    ]
                ),
                TableRow(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 10.0),
                          alignment: Alignment.centerRight,
                          child: Text("RPI #1 IP: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700))
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: widthInputs,
                            child: TextFormField(
                              decoration: new InputDecoration(
                                labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(fontSize: 24.0),
                              controller: rpi1,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Wrap(
                              children: <Widget>[
                                Text("Enabled", style: TextStyle(fontSize: 26.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w600)),
                                Padding(
                                    padding: EdgeInsets.only(left: 5.0, right: 20.0),
                                    child: CPCheckbox(
                                        value: "rpi1",
                                        onChange: (val){
                                          if(val && !_enabled.contains("rpi1")){
                                            _enabled.add("rpi1");
                                          } else if(_primary != "rpi1") {
                                            _enabled.remove("rpi1");
                                          }
                                          print("VAL $val GRP ${_enabled}");
                                        },
                                        groupValue: _enabled
                                    )
                                ),
                                Text("Primary", style: TextStyle(fontSize: 26.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w600)),
                                Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: CPRadio(
                                        value: "rpi1",
                                        onChange: (val){
                                          setState(() {
                                            if(val && _primary != "rpi1"){
                                              _primary = "rpi1";
                                            }
                                            // set enabled as well
                                            if(val && !_enabled.contains("rpi1")) {
                                              _enabled.add("rpi1");
                                            }
                                            print("VAL $val GRP ${_primary}");
                                          });
                                        },
                                        groupValue: _primary
                                    )
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ]
                ),
                TableRow(
                    children: [
                      SizedBox(),
                      Padding(
                        padding: EdgeInsets.only(top: 18.0),
                        child: Row(
                          children: [
                            /*new DanceFrameButton(
                              text: testConnectText1,
                              width: widthInputs,
                              onPressed: () {
                                testConnection(rpi1.text, true);
                              },
                            ),*/
                            connectButton((){
                              testConnection(rpi1.text, true);
                            }),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text("$connectStatus1", style: TextStyle(fontSize: 26.0, color: connectStatusColor1, fontWeight: FontWeight.w600)),
                            )
                          ],
                        ),
                      )
                    ]
                ),
                TableRow(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 25.0)),
                      SizedBox()
                    ]
                ),
                TableRow(
                  children: [
                    Container(
                        padding: EdgeInsets.only(right: 10.0),
                        alignment: Alignment.centerRight,
                        child: Text("RPI #2 IP: ", style: TextStyle(fontSize: 28.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w700))
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: widthInputs,
                          child: TextFormField(
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(fontSize: 24.0),
                            controller: rpi2,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Wrap(
                            children: <Widget>[
                              Text("Enabled", style: TextStyle(fontSize: 26.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w600)),
                              Padding(
                                  padding: EdgeInsets.only(left: 5.0, right: 20.0),
                                  child: CPCheckbox(
                                      value: "rpi2",
                                      onChange: (val){
                                        if(val && !_enabled.contains("rpi2")){
                                          _enabled.add("rpi2");
                                        } else if(_primary != "rpi2") {
                                          _enabled.remove("rpi2");
                                        }
                                        print("VAL $val GRP ${_enabled}");
                                      },
                                      groupValue: _enabled
                                  )
                              ),
                              Text("Primary", style: TextStyle(fontSize: 26.0, color: Color(0xff2f4c5d), fontWeight: FontWeight.w600)),
                              Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: CPRadio(
                                      value: "rpi2",
                                      onChange: (val){
                                        setState(() {
                                          if(val && _primary != "rpi2"){
                                            _primary = "rpi2";
                                          }
                                          // set enabled as well
                                          if(val && !_enabled.contains("rpi2")) {
                                            _enabled.add("rpi2");
                                          }
                                          print("VAL $val GRP ${_primary}");
                                        });
                                      },
                                      groupValue: _primary
                                  )
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ]
                ),
                TableRow(
                    children: [
                      SizedBox(),
                      Padding(
                        padding: EdgeInsets.only(top: 18.0),
                        child: Row(
                          children: [
                            /*new DanceFrameButton(
                              text: testConnectText2,
                              width: widthInputs,
                              onPressed: () {
                                testConnection(rpi2.text, false);
                              },
                            ),*/
                            connectButton((){
                              testConnection(rpi2.text, false);
                            }),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text("$connectStatus2", style: TextStyle(fontSize: 26.0, color: connectStatusColor2, fontWeight: FontWeight.w600)),
                            )
                          ],
                        ),
                      )
                    ]
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: new DanceFrameButton(
                          text: "RESET DEVICE",
                          width: 200.0,
                          onPressed: (){
                            ScreenUtil.showMainFrameDialogWithCancel(context, "Wipe Device Data", "Are you sure you want to wipe all the Data on this device?").then((val){
                              print("VALUE: $val");
                              if(val.toLowerCase() == "ok") {
                                ScreenUtil.showMainFrameDialog(context, "Wipe Device Data", "You pressed OK");
                                DatabaseHelper.instance.removeDB();
                                Preferences.clearPreferences().then((val){
                                  ScreenUtil.showMainFrameDialog(context, "Wipe Success", "Application will restart. Press OK to Exit").then((val){
                                    exit(0);
                                  });
                                });
                              }
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    new DanceFrameButton(
                      text: "EXIT",
                      onPressed: (){
                        if (isNew || hasChangedRPI()) {
                          Navigator.pushNamed(context, "/");
                        } else {
                          Navigator.maybePop(context);
                        }
                      },
                    ),
                    Padding(padding: EdgeInsets.only(left: 10.0)),
                  ],
                ),
                new DanceFrameButton(
                  text: "DISCARD",
                  onPressed: (){
                    _discardDevice();
                  },
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                new DanceFrameButton(
                  text: "SAVE",
                  onPressed: _saveDevice,
                ),
              ],
            )
          ],
        )
    );
  }
}