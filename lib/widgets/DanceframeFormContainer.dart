import 'package:flutter/material.dart';

class DanceframeFormContainer extends StatefulWidget {

  final Alignment alignment;
  final int flex;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double marginBottom;

  const DanceframeFormContainer ({
    Key key,
    this.alignment = Alignment.topLeft,
    this.marginLeft = 80.0,
    this.marginRight = 80.0,
    this.marginTop = 20.0,
    this.marginBottom = 60.0,
    this.flex = 1
  }) : super(key: key);

  @override
  _DanceframeFormContainerState createState() => new _DanceframeFormContainerState();
}

class _DanceframeFormContainerState extends State<DanceframeFormContainer> {


  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(left: widget.marginLeft, right: widget.marginRight, top: widget.marginTop, bottom: widget.marginBottom),
      child: new Column(
        children: <Widget>[
          new Container(
            height: 50.0,
            //color: Colors.red,
            child: new Row(
              children: <Widget>[
                (widget.alignment == Alignment.topLeft) ? new Container(
                  alignment: Alignment.bottomCenter,
                  //color: Colors.green,
                  width: 30.0,
                  child: new Container(
                    height: 28.0,
                    decoration: new BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black, width: 1.5),
                        top: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      color: Colors.white
                    ),
                  ),
                ) :
                new Expanded(
                  child: new Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    decoration: new BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.black, width: 1.5),
                          top: BorderSide(color: Colors.black, width: 1.5),
                        ),
                        color: Colors.white
                    ),
                  )
                ),
                new Expanded(
                  child: new Container(
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.black,
                      borderRadius: new BorderRadius.all(new Radius.circular(8.0))
                    ),
                    child: new Text("MARIA FOLSON", style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    )),
                  ),
                  flex: widget.flex,
                ),
                new Expanded(
                  child: new Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    decoration: new BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.black, width: 1.5),
                        top: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      color: Colors.white
                    )
                  ),
                ),
              ],
            ),
          ),
          new Expanded(
            child: new Container(
              decoration: new BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(width: 1.5),
                  start: BorderSide(width: 1.5),
                  end: BorderSide(width: 1.5)
                ),
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }
}