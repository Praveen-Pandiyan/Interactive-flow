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
    path.moveTo(from.dx, from.dy);
    // Simple straight line; can be improved to bezier for better visuals
    path.lineTo(to.dx, to.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant EdgePainter oldDelegate) {
    return from != oldDelegate.from || to != oldDelegate.to || color != oldDelegate.color;
  }
} 