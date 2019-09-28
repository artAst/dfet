import 'package:flutter/material.dart';

class ScreenUtil {
  static Future<Null> showMainFrameDialog(BuildContext context, String title, String msg, {String uriRedirect}) async {

    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      child: new AlertDialog(
        title: new Text(title),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text(msg)
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}