import 'package:flutter/material.dart';

class Connections extends ChangeNotifier {
  Connections._();
  static final instance = Connections._();
  Offset globalOffset = Offset.zero;
  Map<String, Link> list = {};
  void setGlobalOffset(Offset _offset) {
    if (globalOffset == Offset.zero && _offset != Offset.zero) {
      globalOffset = _offset;
    } else {
      globalOffset -= _offset;
    }
  }

  void create(String id, fromId, Offset delta, localPos) {
    if (list[id] == null) {
      list.addAll({
        id: Link(
            id: id,
            from: fromId,
            start: localPos + globalOffset,
            end: localPos + globalOffset)
      });
    } else {
      positionUpdate(delta, [id], []);
    }
  }

  void positionUpdate(Offset delta, List<String> inpConId, outConId) {
    for (var e in inpConId) {
      if (list[e] != null) {
        list[e]?.end += delta;
      } else {
        // create
      }
    }
    for (var e in outConId) {
      if (list[e] != null) {
        list[e]?.start += delta;
      } else {}
    }
    notifyListeners();
  }

  void onConnection(String id, toId, Offset pos) {
    list[id]
      ?..end = globalOffset + pos
      ..to = toId;
    notifyListeners();
  }
}

class Link {
  String id, from;
  String? to;
  Offset start, end;

  Link({
    required this.id,
    required this.from,
    this.to,
    this.start = Offset.zero,
    this.end = Offset.zero,
  });
  @override
  String toString() {
    // TODO: implement toString

    return "${start} ${end}";
  }
}

class ArrowPainter extends CustomPainter {
  ///
  ArrowPainter({
    required this.from,
    required this.to,
  });

  ///
  final Offset from;

  ///
  final Offset to;

  ///
  final Path path = Path();

  ///
  final List<List<Offset>> lines = [];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 1.0;

    drawCurve(canvas, paint);

    canvas.drawCircle(to, 2, paint);

    paint
      ..color = Colors.black
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  void drawCurve(Canvas canvas, Paint paint) {
    // mutable
    double tension = 1.0;
    Alignment startArrowPosition = Alignment.centerRight;
    Alignment endArrowPosition = Alignment.centerLeft;

    var distance = 0.0;

    var dx = 0.0;
    var dy = 0.0;

    final p0 = Offset(from.dx, from.dy);
    final p4 = Offset(to.dx, to.dy);
    distance = (p4 - p0).distance / 3;

    // checks for the arrow direction
    if (startArrowPosition.x > 0) {
      dx = distance;
    } else if (startArrowPosition.x < 0) {
      dx = -distance;
    }
    if (startArrowPosition.y > 0) {
      dy = distance;
    } else if (startArrowPosition.y < 0) {
      dy = -distance;
    }
    final p1 = Offset(from.dx + dx, from.dy + dy);
    dx = 0;
    dy = 0;

    // checks for the arrow direction
    if (endArrowPosition.x > 0) {
      dx = distance;
    } else if (endArrowPosition.x < 0) {
      dx = -distance;
    }
    if (endArrowPosition.y > 0) {
      dy = distance;
    } else if (endArrowPosition.y < 0) {
      dy = -distance;
    }
    final p3 = endArrowPosition == Alignment.center
        ? Offset(to.dx, to.dy)
        : Offset(to.dx + dx, to.dy + dy);
    final p2 = Offset(
      p1.dx + (p3.dx - p1.dx) / 2,
      p1.dy + (p3.dy - p1.dy) / 2,
    );

    path
      ..moveTo(p0.dx, p0.dy)
      ..conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1)
      ..conicTo(p3.dx, p3.dy, p4.dx, p4.dy, 1);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) {
    return true;
  }

  @override
  bool? hitTest(Offset position) => false;
}
