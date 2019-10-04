import 'package:flutter/widgets.dart' hide Image;
import 'dart:ui';
import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Painter extends StatefulWidget {
  final PainterController painterController;
  final VoidCallback onChanged;

  Painter(PainterController painterController, {this.onChanged})
      : this.painterController = painterController,
        super(key: new ValueKey<PainterController>(painterController));

  @override
  _PainterState createState() => new _PainterState();
}

class _PainterState extends State<Painter> {
  bool _finished;

  @override
  void initState() {
    super.initState();
    _finished = false;
    widget.painterController._widgetFinish = _finish;
    widget.painterController._widgetPartial = _partial;
  }

  Size _finish() {
    setState(() {
      _finished = true;
    });
    return context.size;
  }

  Size _partial() {
    return context.size;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = new CustomPaint(
      willChange: true,
      painter: new _PainterPainter(widget.painterController._pathHistory,
          repaint: widget.painterController),
    );
    child = new ClipRect(child: child);
    if (!_finished) {
      child = new GestureDetector(
        child: child,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
      );
    }
    return new Container(
      child: child,
      width: double.infinity,
      height: double.infinity,
    );
  }

  void _onPanStart(DragStartDetails start) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(start.globalPosition);
    widget.painterController._pathHistory.add(pos);
    widget.painterController._notifyListeners();
  }

  void _onPanUpdate(DragUpdateDetails update) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(update.globalPosition);
    widget.painterController._pathHistory.updateCurrent(pos);
    widget.painterController._notifyListeners();
  }

  void _onPanEnd(DragEndDetails end) {
    widget.painterController._pathHistory.endCurrent();
    widget.painterController._notifyListeners();
    if(widget.onChanged != null) {
      Function.apply(widget.onChanged, []);
    }
  }
}

class _PainterPainter extends CustomPainter {
  final _PathHistory _path;

  _PainterPainter(this._path, {Listenable repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    _path.draw(canvas, size);
  }

  @override
  bool shouldRepaint(_PainterPainter oldDelegate) {
    return true;
  }
}

class _PathHistory {
  List<MapEntry<Path, Paint>> _paths;
  Paint currentPaint;
  Paint _backgroundPaint;
  bool _inDrag;

  _PathHistory() {
    _paths = new List<MapEntry<Path, Paint>>();
    _inDrag = false;
    _backgroundPaint = new Paint();
  }

  void setBackgroundColor(Color backgroundColor) {
    _backgroundPaint.color = backgroundColor;
  }

  void undo() {
    if (!_inDrag) {
      _paths.removeLast();
    }
  }

  void clear() {
    if (!_inDrag) {
      _paths.clear();
    }
  }

  void add(Offset startPoint) {
    if (!_inDrag) {
      _inDrag = true;
      Path path = new Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      _paths.add(new MapEntry<Path, Paint>(path, currentPaint));
    }
  }

  void updateCurrent(Offset nextPoint) {
    if (_inDrag) {
      Path path = _paths.last.key;
      path.lineTo(nextPoint.dx, nextPoint.dy);
    }
  }

  void endCurrent() {
    _inDrag = false;
  }

  void draw(Canvas canvas, Size size) {
    canvas.drawRect(
        new Rect.fromLTWH(0.0, 0.0, size.width, size.height), _backgroundPaint);
    for (MapEntry<Path, Paint> path in _paths) {
      canvas.drawPath(path.key, path.value);
    }
  }
}

typedef PictureDetails PictureCallback();

class PictureDetails {
  final Picture picture;
  final int width;
  final int height;

  const PictureDetails(this.picture, this.width, this.height);

  Future<Image> toImage() async {
    return await picture.toImage(width, height);
  }

  Future<Uint8List> toPNG() async {
    return (await (await toImage()).toByteData(format: ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
}

class PainterController extends ChangeNotifier {
  Color _drawColor = new Color.fromARGB(255, 0, 0, 0);
  Color _backgroundColor = new Color.fromARGB(255, 255, 255, 255);

  double _thickness = 1.0;
  PictureDetails _cached;
  _PathHistory _pathHistory;
  ValueGetter<Size> _widgetFinish;
  ValueGetter<Size> _widgetPartial;

  PainterController() {
    _pathHistory = new _PathHistory();
  }

  Color get drawColor => _drawColor;
  set drawColor(Color color) {
    _drawColor = color;
    _updatePaint();
  }

  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color color) {
    _backgroundColor = color;
    _updatePaint();
  }

  double get thickness => _thickness;
  set thickness(double t) {
    _thickness = t;
    _updatePaint();
  }

  void _updatePaint() {
    Paint paint = new Paint();
    paint.color = drawColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = thickness;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    _pathHistory.currentPaint = paint;
    _pathHistory.setBackgroundColor(backgroundColor);
    notifyListeners();
  }

  void undo() {
    if (!isFinished()) {
      _pathHistory.undo();
      notifyListeners();
    }
  }

  void _notifyListeners() {
    notifyListeners();
  }

  void clear() {
    if (!isFinished()) {
      _pathHistory.clear();
      notifyListeners();
    }
  }

  PictureDetails finish(String filename) {
    if (!isFinished()) {
      _cached = _render(_widgetFinish(), filename);
    }
    return _cached;
  }

  PictureDetails partial(String filename) {
    print("isFinished: ${isFinished()}");
    if (!isFinished()) {
      _render(_widgetPartial(), filename);
    }
    return _cached;
  }

  PictureDetails _render(Size size, String filename) {
    print("RENDER");
    PictureRecorder recorder = new PictureRecorder();
    Canvas canvas = new Canvas(recorder);
    _pathHistory.draw(canvas, size);
    _pathHistory._paths;

    PictureDetails pd = new PictureDetails(
        recorder.endRecording(), size.width.floor(), size.height.floor());

    saveImage(pd, filename);

    return pd;
  }

  Future saveImage(PictureDetails pd, String filename) async {
    print("SAVE IMAGE");
    var pngBytes = await pd.toPNG();
    print("PNG BYTES generated");
    final String path = (await getApplicationDocumentsDirectory()).path;
    try {
      File file = new File('$path/$filename.png');
      file.exists().then((val){
        if(val) {
          file.delete();
          file = new File('$path/$filename.png');
        }
        file.writeAsBytesSync(pngBytes);
      });
    } catch (error) {
      print("has errors ${error}");
    }
    print("SAVED FILE");
    //check if file exists
    File f = new File('$path/$filename.png');
    f.exists().then((val){
      if(val)
        print("Filename [${filename}] existed");
      else
        print("saveImage: Does not exists");
    });
  }

  Future deleteImage(String filename) async {
    final String path = (await getApplicationDocumentsDirectory()).path;
    File f = new File('$path/$filename.png');
    f.exists().then((val){
      if(val) {
        print("Filename [${filename}] existed. Deleting file...");
        f.delete();
      }
      else {
        print("deleteImage: Does not exists");
      }
    });
  }

  bool isFinished() {
    return _cached != null;
  }

  bool hasDrawContent() {
    if(_pathHistory._paths.isNotEmpty) {
      return true;
    }
    return false;
  }
}