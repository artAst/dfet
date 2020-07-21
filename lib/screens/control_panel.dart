import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/MFTabComponent.dart';
import 'package:danceframe_et/widgets/Device1ControlPanel.dart';
import 'package:danceframe_et/widgets/Global1ControlPanel.dart';
import 'package:danceframe_et/widgets/Global2ControlPanel.dart';
import 'package:danceframe_et/widgets/Global3ControlPanel.dart';
import 'package:danceframe_et/widgets/Global4ControlPanel.dart';

class control_panel extends StatefulWidget {
  @override
  _control_panelState createState() => new _control_panelState();
}

class _control_panelState extends State<control_panel> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 150.0,
          mode: "TITLE",
          headerText: "CONFIGURATION SETUP",
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
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 2.0),
                          right: BorderSide(width: 2.0),
                          left: BorderSide(width: 2.0)
                      )
                  ),
                  child: new MFTabbedComponentDemoScaffold(
                      demos: <MFComponentDemoTabData>[
                        new MFComponentDemoTabData(
                          tabName: 'Device',
                          description: '',
                          demoWidget: Device1ControlPanel(),
                        ),
                        new MFComponentDemoTabData(
                          tabName: 'Global 1',
                          description: '',
                          demoWidget: Global1ControlPanel(),
                        ),
                        new MFComponentDemoTabData(
                          tabName: 'Global 2',
                          description: '',
                          demoWidget: Global2ControlPanel(),
                        ),
                        new MFComponentDemoTabData(
                          tabName: 'Global 3',
                          description: '',
                          demoWidget: Global3ControlPanel(),
                        ),
                        new MFComponentDemoTabData(
                          tabName: 'Global 4',
                          description: '',
                          demoWidget: Global4ControlPanel(),
                        ),
                      ]
                  ),
                ),
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