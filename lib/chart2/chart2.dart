import 'package:flutter/material.dart';

import '../chozo_flow/connections.dart';

class Chart2 extends StatefulWidget {
  const Chart2({super.key});

  @override
  State<Chart2> createState() => _Chart2State();
}

class _Chart2State extends State<Chart2> {
  double scale = 1;
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
    return InteractiveViewer(
        onInteractionUpdate: (details) {
          setState(() {
            scale = details.scale;
          });
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            ..._connections.linkList.values.map((e) => CustomPaint(
                  painter: ArrowPainter(from: e.start, to: e.end),
                  child: Container(),
                )),

                
          ],
        ));
    ;
  }
}
