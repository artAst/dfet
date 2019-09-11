import 'package:flutter/material.dart';

class GenderRadioBtn extends StatefulWidget {
  final String labelText;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;
  final Color activeColor;

  const GenderRadioBtn({
    Key key,
    @required this.value,
    @required this.labelText,
    @required this.groupValue,
    @required this.onChanged,
    this.activeColor
  }) : super(key: key);

  _GenderRadioBtnState createState() => new _GenderRadioBtnState();
}

class _GenderRadioBtnState extends State<GenderRadioBtn> {
  Widget _temp = new Icon(Icons.radio_button_unchecked);

  @override
  Widget build(BuildContext context) {
    if(widget.groupValue == widget.value) {
      _temp = new Icon(Icons.radio_button_checked);
    }
    else {
      _temp = new Icon(Icons.radio_button_unchecked);
    }

    return new InkWell(
      onTap: (){
        widget.onChanged(widget.value);
      },
      child: new Row(
        children: <Widget>[
          (widget.labelText == "Gentleman") ? new Image.asset("assets/images/Asset_2_4x.png") : new Image.asset("assets/images/Asset_1_4x.png"),
          new Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              child: _temp
          ),
          new Text(widget.labelText, style: TextStyle(fontSize: 22.0))
        ],
      ),
    );
  }
}