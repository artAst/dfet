import 'package:flutter/material.dart';

class ComponentCheckbox extends StatefulWidget {

  final String text;

  const ComponentCheckbox({
    Key key,
    this.text = "",
  }) : super(key: key);

  @override
  _ComponentCheckboxState createState() => new _ComponentCheckboxState();
}

class _ComponentCheckboxState extends State<ComponentCheckbox> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(2.0),
      constraints: BoxConstraints(
        minWidth: 200.0,
        maxWidth: 200.0
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.black)
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(widget.text, style: TextStyle(fontSize: 18.0)),
            )
          ),
          new InkWell(
            onTap: () {
              setState(() {
                if(isChecked) {
                  isChecked = false;
                } else {
                  isChecked = true;
                }
              });
            },
            child: new Container(
                decoration: BoxDecoration(
                  border: Border(left: BorderSide()),
                ),
                width: 30.0,
                child: (isChecked) ? new Icon(Icons.check) : new Container(height: 24.0)
            )
          )
        ],
      ),
    );
  }
}