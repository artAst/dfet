import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainer.dart';
import 'package:flutter/services.dart';

class change_device_mode extends StatefulWidget {
  @override
  _change_device_modeState createState() => new _change_device_modeState();
}

class _change_device_modeState extends State<change_device_mode> {

  TextEditingController _deviceModeCtrl = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  String code1 = "";
  String code2 = "";
  String code3 = "";

  void textListener() {
    setState(() {
      if(_deviceModeCtrl.text.length > 0) {
        code1 = _deviceModeCtrl.text[0];
        if(_deviceModeCtrl.text.length > 1) {
          code2 = _deviceModeCtrl.text[1];
          if(_deviceModeCtrl.text.length > 2) {
            code3 = _deviceModeCtrl.text[2];
          }
          else {
            code3 = "";
          }
        } else {
          code2 = "";
        }
      } else {
        code1 = "";
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _deviceModeCtrl.addListener(textListener);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new DanceframeAppBar(
          height: 150.0,
          bg: true,
        ),
        body: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [new Color(0xFFD6DFDE), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.01, 0.5]
              )
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                // PUT YOUR CONTENTS HERE in Child property
                  child: new DanceframeFormContainer(
                      alignment: Alignment.topCenter,
                      marginRight: 140.0,
                      marginLeft: 140.0,
                      marginBottom: 380.0,
                      flex: 3.0,
                      headingHeight: 40.0,
                      containerMarginTop: 26.0,
                      background: Colors.white,
                      headingText: "CHANGE DEVICE MODE",
                      child: new Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                        child: new Column(
                          children: <Widget>[
                            new Expanded(
                              child: Container(
                                //color: Colors.amber,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Stack(
                                      children: <Widget>[
                                        new Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            new InkWell(
                                              onTap: (){
                                                FocusScope.of(context).requestFocus(_focusNode);
                                              },
                                              child: new Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  border: Border.all(),
                                                ),
                                                width: 100.0,
                                                height: 100.0,
                                                child: new Center(
                                                  child: Text(code1, style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w600)),
                                                ),
                                              )
                                            ),
                                            new InkWell(
                                                onTap: (){
                                                  FocusScope.of(context).requestFocus(_focusNode);
                                                },
                                                child: new Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    border: Border.all(),
                                                  ),
                                                  width: 100.0,
                                                  height: 100.0,
                                                  child: new Center(
                                                    child: Text(code2, style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w600)),
                                                  ),
                                                )
                                            ),
                                            new InkWell(
                                                onTap: (){
                                                  FocusScope.of(context).requestFocus(_focusNode);
                                                },
                                                child: new Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    border: Border.all(),
                                                  ),
                                                  width: 100.0,
                                                  height: 100.0,
                                                  child: new Center(
                                                    child: Text(code3, style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w600)),
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    new Container(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text("ACCESS CODE", style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w900
                                      )),
                                    ),
                                    new Container(
                                      padding: EdgeInsets.only(left: 20.0, top: 5.0),
                                      child: new TextField(
                                        autofocus: true,
                                        style: TextStyle(
                                          fontSize: 1.0,
                                          //fontWeight: FontWeight.w600,
                                          //letterSpacing: 100.0
                                        ),
                                        decoration: InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          border: InputBorder.none
                                        ),
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: <TextInputFormatter>[
                                          new LengthLimitingTextInputFormatter(3)
                                        ],
                                        cursorColor: Colors.white,
                                        controller: _deviceModeCtrl,
                                        focusNode: _focusNode,
                                      ),
                                    )
                                  ],
                                )
                              )
                            ),
                            new Container(
                              height: 45.0,
                              child: new Row(
                                children: <Widget>[
                                  new DanceFrameButton(text: "CANCEL"),
                                  new Expanded(child: Container()),
                                  new DanceFrameButton(
                                      onPressed: () => Navigator.pushNamed(context, "/contactUs"),
                                      width: 140.0,
                                      text: "CONTINUE"
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  )
              ),
              new Container(
                decoration: new BoxDecoration(
                    border: new Border(
                        top: BorderSide(color: Colors.black)
                    )
                ),
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Powered By: ", style: new TextStyle(fontSize: 16.0)),
                    new Padding(padding: const EdgeInsets.only(top: 5.0)),
                    new Image.asset("assets/images/Asset_43_4x.png", height: 25.0)
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}