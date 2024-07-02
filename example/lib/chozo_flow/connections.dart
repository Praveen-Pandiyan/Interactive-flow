  import 'package:flutter/material.dart';
  

class ArrowPainter extends CustomPainter {
  ///
  ArrowPainter({
    required this.from,
    required this.to,
  }) ;


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
   double tension =1.0;
    Alignment startArrowPosition= Alignment.centerRight;
    Alignment endArrowPosition= Alignment.centerLeft;


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
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
  }
