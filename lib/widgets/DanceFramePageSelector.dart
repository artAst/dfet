import 'package:flutter/material.dart';
import 'MFTabPageSelector.dart';
import 'MFTabPageArrow.dart';

class PageSelectData {
  PageSelectData({
    this.demoWidget,
    this.exampleCodeTag,
    this.description,
    this.tabName,
    this.loadMoreCallback,
    this.refreshCallback
  });

  final Widget demoWidget;
  final String exampleCodeTag;
  final String description;
  final String tabName;
  final VoidCallback loadMoreCallback;
  final VoidCallback refreshCallback;

  @override
  bool operator==(Object other) {
    if (other.runtimeType != runtimeType)
      return false;
    final PageSelectData typedOther = other;
    return typedOther.tabName == tabName && typedOther.description == description;
  }

  @override
  int get hashCode => hashValues(tabName.hashCode, description.hashCode);
}

class _PageSelector extends StatefulWidget {

  List<PageSelectData> pageWidgets;

  _PageSelector({this.pageWidgets});

  @override
  _PageSelectorState createState() => new _PageSelectorState();
}

class _PageSelectorState extends State<_PageSelector> {

  void _handleArrowButtonPress(int delta) {
    final TabController controller = DefaultTabController.of(context);
    setState((){
      if (!controller.indexIsChanging)
        controller.animateTo((controller.index + delta).clamp(0, widget.pageWidgets.length - 1));
      //print("idx: ${controller.index} prev: ${controller.previousIndex}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final TabController controller = DefaultTabController.of(context);
    final Color color = Theme.of(context).accentColor;
    return new Column(
      children: <Widget>[
        new Container(
          //color: Colors.amber,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 180.0,
                  height: 100.0,
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                          child: new InkWell(
                            onTap: (){
                              _handleArrowButtonPress(-1);
                            },
                            child: Container(
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Color(0xFF2e4c5e)
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5.0),
                              child: new Wrap(
                                alignment: WrapAlignment.center,
                                children: <Widget>[
                                  new RichText(
                                    text: TextSpan(
                                        style: new TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text: "Critique ${widget.pageWidgets[0].tabName}"
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            )
                          )
                      ),
                      new Container(
                        alignment: Alignment.center,
                        child: Text("${widget.pageWidgets[0].description}", style: new TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        )),
                      )
                    ],
                  ),
                ),
                new Padding(padding: EdgeInsets.only(left: 30.0)),
                new Container(
                  width: 180.0,
                  height: 100.0,
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                          child: new InkWell(
                            onTap: (){
                              _handleArrowButtonPress(1);
                            },
                            child: Container(
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Color(0xFF2e4c5e)
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5.0),
                              child: new Wrap(
                                alignment: WrapAlignment.center,
                                children: <Widget>[
                                  new RichText(
                                    text: TextSpan(
                                        style: new TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text: "Critique ${widget.pageWidgets[1].tabName}"
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            )
                          )
                      ),
                      new Container(
                        alignment: Alignment.center,
                        child: Text("${widget.pageWidgets[1].description}", style: new TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ),
        new Expanded(
          child: new TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: widget.pageWidgets.map<Widget>((_w){
                return _w.demoWidget;
              }).toList()
          ),
        ),
      ],
    );
  }
}

class MFPageSelector extends StatefulWidget {

  List<PageSelectData> pageWidgets;

  MFPageSelector({this.pageWidgets});

  @override
  _MFPageSelectorState createState() => new _MFPageSelectorState();
}

class _MFPageSelectorState extends State<MFPageSelector> {

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: widget.pageWidgets.length,
      child: new _PageSelector(pageWidgets: widget.pageWidgets),
    );
  }
}