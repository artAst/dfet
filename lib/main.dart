import 'package:flutter/material.dart';
import 'package:danceframe_et/route/DanceframeRoute.dart';

void main() => runApp(DanceframeET());

class DanceframeET extends StatefulWidget {

  @override
  _DanceframeETState createState() => _DanceframeETState();
}

class _DanceframeETState extends State<DanceframeET> {

  @override
  Widget build(BuildContext context) {
    ThemeData theme = new ThemeData(
      primaryColor: new Color(0xFF324261),
      fontFamily: "Montserrat-Regular",
      canvasColor: new Color(0xFF324261),
      brightness: Brightness.dark,
      hintColor: Colors.white,
      accentColor: Colors.white,
      dialogBackgroundColor: new Color(0xFF324261),
      textSelectionHandleColor: new Color(0xFF53617C),
    );

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: getMainFrameOnRoute,
      routes: getMainFrameRoute(),
      //theme: theme,
    );
  }
}
