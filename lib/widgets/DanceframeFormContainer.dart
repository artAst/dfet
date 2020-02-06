import 'package:flutter/material.dart';
import 'package:danceframe_et/enums/FormContainerType.dart';

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
  final FormContainerType containerType;
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
    this.containerType = FormContainerType.ROUNDED,
    this.child,
  }) : super(key: key);

  @override
  _DanceframeFormContainerState createState() => new _DanceframeFormContainerState();
}

class _DanceframeFormContainerState extends State<DanceframeFormContainer> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if(widget.containerType == FormContainerType.ROUNDED) {
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
                  padding: EdgeInsets.only(
                      top: widget.headingHeight / 2 + 10.0),
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
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: widget.headerMarginTop),
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
          ],
        ),
      );
    } else {
      //
      //  BOXED CONTAINER
      //
      return new Container(
        margin: EdgeInsets.only(
            left: widget.marginLeft,
            right: widget.marginRight,
            //top: widget.marginTop,
            bottom: widget.marginBottom
        ),
        child: new Stack(
          children: <Widget>[
            new Align(
              alignment: Alignment.topCenter,
              child: new Container(
                //margin: EdgeInsets.only(top: widget.containerMarginTop),
                //padding: EdgeInsets.only(
                //    top: widget.headingHeight / 2 + 10.0),
                decoration: new BoxDecoration(
                    color: widget.background,
                    border: Border.all(color: Colors.black, width: 1.5)
                ),
                child: new ConstrainedBox(
                  constraints: BoxConstraints.expand(),
                  // contents here at CHILD
                  child: widget.child
                )
              ),
            )
          ],
        ),
      );
    }
  }
}