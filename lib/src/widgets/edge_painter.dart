import 'package:flutter/material.dart';

class EdgePainter extends CustomPainter {
  final Offset from;
  final Offset to;
  final Color color;

  EdgePainter({required this.from, required this.to, this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final path = Path();
    // Draw a smooth curve (bezier/conic)
    final distance = (to - from).distance / 3;
    final p1 = Offset(from.dx + distance, from.dy);
    final p2 = Offset(to.dx - distance, to.dy);
    path.moveTo(from.dx, from.dy);
    path.cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, to.dx, to.dy);
    canvas.drawPath(path, paint);
    // Draw a small circle at the end
    canvas.drawCircle(to, 3, paint);
  }

  @override
  bool shouldRepaint(covariant EdgePainter oldDelegate) {
    return from != oldDelegate.from || to != oldDelegate.to || color != oldDelegate.color;
  }
} 