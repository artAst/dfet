import 'package:danceframe_et/util/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:danceframe_et/model/config/EventConfig.dart';
import 'package:danceframe_et/model/config/DeviceConfig.dart';

class DanceframeAppBar extends StatefulWidget implements PreferredSizeWidget {

  final double height;
  final String mode;
  final bool bg;
  final String headerText;
  final bool hasBorder; 
  
  const DanceframeAppBar({
    Key key,
    this.height = 110.0,
    this.mode = "LOGO",
    this.bg = false,
    this.headerText = "",
    this.hasBorder = true,  
  }) : super(key: key);

  
  @override
  Size get preferredSize => Size.fromHeight(this.height);

  @override
  _DanceframeAppBarState createState() => _DanceframeAppBarState();
}

class _DanceframeAppBarState extends State<DanceframeAppBar>{
  String deviceNumber = "";
  bool isRPIFail = false;
  @override
  void initState() {
    //getDeviceNumber();
    super.initState();
    Preferences.getSharedValue("rpiFail").then((value) {
      if(value == "true") {
        isRPIFail = true;
      }
      else {
        isRPIFail = false;
      }
    });
  }


  Future<String> getDeviceNumber() async {
    final res = await Preferences.getSharedValue("deviceNumber");
    deviceNumber = res;
    if(res != null) {
      return res.toString();
    } else {
      return "";
    }
  }

  void cogIconTapped() {
    print("Navigate");
    Navigator.pushNamed(context, "/changeDeviceMode").then((value) {
      print("HAS ALREADY POPPED. RERENDER STATE");
      setState(() {
        deviceNumber = DeviceConfig.deviceNum;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("DANCEFRAME APPBAR DEVICE CONFIG NUM: ${DeviceConfig.deviceNum}");

    LinearGradient gradientTop = new LinearGradient(
        colors: [new Color(0xFFADC0BE), new Color(0xFFD6DFDE)],
        //colors: [Colors.red, Colors.blue],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.05, 1.0]
    );


    return new Theme(
      data: new ThemeData(
        fontFamily: "Helvetica",
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
            color: Colors.black,
            height: 25.0,
          ),
          new Expanded(
            flex: 2,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    //color: new Color(0xFFADC0BE),
                    decoration: new BoxDecoration(
                      gradient: gradientTop,
                    ),
                    child: new Align(
                      alignment: Alignment.topLeft,
                      child: (!widget.bg) ? new Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                        //child: new Icon(Icons.settings, size: 40.0, color: Colors.white)
                        child: new InkWell(
                          onTap: cogIconTapped,
                          child: new Image.asset("assets/images/cog.png", height: 40.0),
                        )
                      ) :
                      new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          //child: new Icon(Icons.settings, size: 40.0, color: Colors.white)
                          child: new InkWell(
                            //onTap: () => Navigator.popUntil(context, ModalRoute.withName("/deviceMode")),
                            //onTap: () => Navigator.pushNamed(context, "/changeDeviceMode"),
                            onTap: cogIconTapped,
                            child: new Container(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                              decoration: new BoxDecoration(
                                  color: new Color(0xFF577587),
                                  borderRadius: new BorderRadius.only(
                                    topRight: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(blurRadius: 1.0),
                                  ],
                                  border: new Border.all(color: Colors.black, width: 0.5)
                              ),
                              height: 50.0,
                              width: 70.0,
                              child: new Image.asset("assets/images/cog.png", height: 40.0),
                            )
                          )
                      )
                    )
                  )
                ),
                new Expanded(
                  child: new Container(
                    //color: Colors.green,
                    decoration: new BoxDecoration(
                      gradient: gradientTop,
                      //color: Colors.green
                    ),
                    child: new Align(
                      alignment: Alignment.center,
                      child: (widget.mode != "LOGO") ? new Text((EventConfig.eventName != null && !isRPIFail) ? EventConfig.eventName: "", style: new TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ), textAlign: TextAlign.center) :
                      new Container(
                        margin: const EdgeInsets.only(top: 20.0, left: 100.0, right: 100.0),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new ExactAssetImage("assets/images/Asset_43_4x.png"),
                            fit: BoxFit.fitWidth
                          )
                        ),
                      ),
                    ),
                  ),
                  flex: 6,
                ),
                new Expanded(
                    child: new Container(
                      //color: Colors.blue,
                      decoration: new BoxDecoration(
                        gradient: gradientTop
                      ),
                      child: new Align(
                          alignment: Alignment.topRight,
                        child: (!widget.bg) ? new Padding(
                          padding: const EdgeInsets.only(right: 15.0, top: 15.0),
                          //child: new Icon(Icons.settings, size: 40.0, color: Colors.white)
                          child: new Image.asset("assets/images/this_device.png", height: 40.0),
                        ) :
                        new Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            //child: new Icon(Icons.settings, size: 40.0, color: Colors.white)
                            child: new Container(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                              decoration: new BoxDecoration(
                                  color: new Color(0xFF577587),
                                  borderRadius: new BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(blurRadius: 1.0),
                                  ],
                                  border: new Border.all(color: Colors.black, width: 0.5)
                              ),
                              height: 50.0,
                              width: 70.0,
                              child: Center(
                                child: Text(
                                  // (widget.isDeviceUpdated == true) ? widget.deviceNumber : deviceNumber,
                                  (DeviceConfig.deviceNum != null) ? DeviceConfig.deviceNum : "",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                )
                              ),
                            )
                        )
                      )
                    )
                ),
              ],
            ),
          ),
          new Expanded(
              child: new Container(
                color: new Color(0xFFD6DFDE),
                //color: Colors.amber,
                constraints: BoxConstraints(minHeight: 60.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Expanded(
                      child: (widget.hasBorder) ? new SizedBox(
                        height: 1.0,
                        child: new Container(
                          color: Colors.black,
                        ),
                      ) : new Container()
                    ),
                    new Expanded(
                      child: (widget.mode != "LOGO" && widget.headerText.isNotEmpty) ? new Container(
                        //padding: const EdgeInsets.all(10.0),
                        height: 60.0,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(8.0),
                          color: Colors.black
                        ),
                        child: new Text(widget.headerText, style: new TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )),
                      ) :
                      (widget.hasBorder) ?
                      new SizedBox(
                        height: 1.0,
                        child: new Container(
                          color: Colors.black,
                        ),
                      ) : new Container(),
                      flex: 2,
                    ),
                    new Expanded(
                      child: (widget.hasBorder) ? new SizedBox(
                        height: 1.0,
                        child: new Container(
                          color: Colors.black,
                        ),
                      ) : new Container()
                    ),
                  ],
                )
              ),
          )
        ],
      )
    );
  }

}