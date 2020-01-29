import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class ImageLocal extends StatefulWidget {

  final String filename;
  final double width;
  final double height;

  const ImageLocal({
    Key key,
    this.filename,
    this.width = 300.0,
    this.height = 450.0
  }) : super(key: key);

  @override
  _ImageLocalState createState() => new _ImageLocalState();
}

class _ImageLocalState extends State<ImageLocal> {
  File _imgFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImage();
  }

  void loadImage() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      _imgFile = new File('$path/${widget.filename}.png');
      _imgFile.exists().then((val){
        if(val)
          print("Filename [${widget.filename}] existed");
        else
          print("saveImage: Does not exists");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_imgFile != null) ? Image.file(_imgFile, width: widget.width, height: widget.height) : Container();
  }
}