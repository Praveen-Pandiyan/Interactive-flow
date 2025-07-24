import 'package:flutter/material.dart';

class PinWidget extends StatelessWidget {
  final String pinId;
  final bool isInput;
  final Color color;
  final VoidCallback? onTap;

  const PinWidget({Key? key, required this.pinId, this.isInput = true, this.color = Colors.blue, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black26),
        ),
        child: Center(
          child: Icon(isInput ? Icons.arrow_left : Icons.arrow_right, size: 12, color: Colors.white),
        ),
      ),
    );
  }
} 