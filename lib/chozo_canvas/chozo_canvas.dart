import 'package:chozo_ui_package/chozo_flow/connections.dart';
import 'package:flutter/material.dart';

class ChozoCanvas extends StatefulWidget {
  const ChozoCanvas({super.key});

  @override
  State<ChozoCanvas> createState() => _ChozoCanvasState();
}

class _ChozoCanvasState extends State<ChozoCanvas> {
  double pd = 1.0, scale = 1.0;
  final Connections _connections = Connections.instance;
  @override
  void initState() {
    _connections.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pd = MediaQuery.devicePixelRatioOf(context);
    return InteractiveViewer(
      onInteractionUpdate: (details) {
        scale = 1.0;
      },
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          ..._connections.linkList.values.map((e) => CustomPaint(
                painter: ArrowPainter(from: e.start, to: e.end),
                child: Container(),
              )), 
        ],
      ),
    );
  }
}
