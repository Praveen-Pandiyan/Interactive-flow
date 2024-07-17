import 'dart:math';

import 'package:flutter/material.dart';

class ChartView extends StatefulWidget {
  const ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  Offset _gblPos = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: GestureDetector(
        onPanUpdate: (d) {
          setState(() {
            _gblPos += d.delta;
          });
        },
        child: Stack(
          children: [
            Container(
              color: Colors.red,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
            ),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
            Box(gblPos: _gblPos),
          ],
        ),
      ),
    );
  }
}

class Box extends StatefulWidget {
  final Offset gblPos;
  const Box({super.key, required this.gblPos});

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  Offset _pointer = randomOffset();
  final Color _color = randomColor();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.gblPos.dx + _pointer.dx,
      top: widget.gblPos.dy + _pointer.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _pointer += details.delta;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
              color: _color),
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}

Color randomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}

randomOffset() {
  return Offset(Random().nextInt(200) + 1, Random().nextInt(200) + 1);
}
