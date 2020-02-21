import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Painter.dart';

class PainterStack extends StatefulWidget {
  PainterController painterController;
  final VoidCallback onChanged;
  
  PainterStack(this.painterController, {this.onChanged});
  
  @override
  _PainterStackState createState() => new _PainterStackState();
}

class _PainterStackState extends State<PainterStack> {

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Painter(widget.painterController, onChanged: widget.onChanged),
        Positioned(
            bottom: 5.0,
            left: 5.0,
            child: InkWell(
              onTap: () => widget.painterController.clear(),
              child: CircleAvatar(
                radius: 12.0,
                child: Icon(Icons.clear, size: 18.0),
              ),
            )
        ),
      ],
    );
  }
}