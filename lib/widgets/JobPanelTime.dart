import 'package:flutter/material.dart';

class JobPanelTime extends StatefulWidget {
  @override
  _JobPanelTimeState createState() => new _JobPanelTimeState();
}

class _JobPanelTimeState extends State<JobPanelTime> {

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
        padding: EdgeInsets.only(right: 5.0, top: 5.0, bottom: 5.0),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              //padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Color(0xff97040c),
                  borderRadius: BorderRadius.circular(10.0),
                  //border: Border.all(color: Colors.black, width: 1.5)
                ),
                constraints: BoxConstraints(minHeight: 50.0, minWidth: 140.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("OFFICIAL TIME", style: TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.w800)),
                    Text("9:00 AM", style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w800)),
                  ],
                )
            )
          ],
        )
    );
  }
}