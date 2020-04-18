import 'package:flutter/material.dart';

class DanceframeFormContainer extends StatefulWidget {

  final Alignment alignment;
  final double headingHeight;
  final double headerMarginTop;
  final double containerMarginTop;
  final double flex;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double marginBottom;
  final Color background;
  final String headingText;
  final Widget child;

  const DanceframeFormContainer ({
    Key key,
    this.alignment = Alignment.topLeft,
    this.marginLeft = 40.0,
    this.marginRight = 40.0,
    this.marginTop = 10.0,
    this.marginBottom = 30.0,
    this.headingHeight = 50.0,
    this.headerMarginTop = 7.0,
    this.containerMarginTop = 30.0,
    this.flex = 2.3,
    this.headingText = "",
    this.background,
    this.child,
  }) : super(key: key);

  @override
  _DanceframeFormContainerState createState() => new _DanceframeFormContainerState();
}

class _DanceframeFormContainerState extends State<DanceframeFormContainer> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return new Container(
      margin: EdgeInsets.only(
          left: widget.marginLeft,
          right: widget.marginRight,
          top: widget.marginTop,
          bottom: widget.marginBottom
      ),
      child: new Stack(
        children: <Widget>[
          new Align(
            alignment: Alignment.bottomCenter,
            child: new Container(
                margin: EdgeInsets.only(top: widget.containerMarginTop),
                padding: EdgeInsets.only(top: widget.headingHeight / 2 + 10.0),
                decoration: new BoxDecoration(
                    color: widget.background,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black, width: 1.5)
                ),
                child: new ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    // contents here at CHILD
                    child: widget.child
                )
            ),
          ),
          new Align(
            alignment: widget.alignment,
            child: new Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: widget.headerMarginTop),
              width: screenWidth / widget.flex,
              height: widget.headingHeight,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                  color: Colors.black,
                  borderRadius: new BorderRadius.all(new Radius.circular(8.0))
              ),
              child: new Text(widget.headingText, style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              )),
            ),
          ),
          new Align(
            alignment: Alignment.topRight,
            child: new Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              width: 100.0,
              height: 100.0,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                  color: Colors.grey,
                  borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
                  border: Border.all(color: Colors.black),
              ),
              child: new Container(
                margin: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage("assets/images/person.png"),
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.center
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}