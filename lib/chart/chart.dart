import 'dart:math';
import 'package:uuid/uuid.dart';

import '../chozo_flow/connections.dart';
import 'package:flutter/material.dart';

class ChartView extends StatefulWidget {
  const ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

GlobalKey globalWidgetKey = GlobalKey();

class _ChartViewState extends State<ChartView> {
  Offset _gblPos = Offset.zero;
  final Connections _connections = Connections.instance;
  GlobalKey _key = GlobalKey();
  @override
  void initState() {
    _connections.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: globalWidgetKey,
      child: InteractiveViewer(
        boundaryMargin: EdgeInsets.zero,
        child: GestureDetector(
          onPanUpdate: (d) {
            setState(() {
              _gblPos += d.delta;
            });
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              ..._connections.linkList.values.map((e) => CustomPaint(
                    painter: ArrowPainter(
                        from: _gblPos + e.start, to: _gblPos + e.end),
                    child: Container(),
                  )),
              ..._connections.linkList.values.map((e) => Text(e.id)),
              FlowContainer(
                gblPos: _gblPos,
              ),
              FlowContainer(
                gblPos: _gblPos,
              ),
            ],
          ),
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

// temp

class FlowContainer extends StatefulWidget {
  final String? id;
  final Offset gblPos;
  const FlowContainer({super.key, this.id, required this.gblPos});

  @override
  State<FlowContainer> createState() => _FlowContainerState();
}

class _FlowContainerState extends State<FlowContainer> {
  final Connections _connections = Connections.instance;
  Offset _localPos = randomOffset();
  List<String> inpLinks = [], outLinks = [];
  final Color _color = randomColor();

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: widget.gblPos.dx + _localPos.dx,
        top: widget.gblPos.dy + _localPos.dy,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          FlowInPin(
            boxId: "c",
            pinId: "c1",
            addInLink: inpLinks.add,
          ),
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _localPos = _localPos + details.delta;
              });

              _connections.positionUpdate(details.delta, inpLinks, outLinks);
            },
            child: Container(width: 100, height: 100, color: _color),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              FlowOutPin(
                boxId: "a",
                pinId: "a1",
                addOutLink: outLinks.add,
              ),
              FlowOutPin(
                boxId: "a",
                pinId: "a2",
                addOutLink: outLinks.add,
              ),
            ],
          ),
        ]));
  }
}

_getPositionOfBox(GlobalKey inKey) {
  RenderBox box = inKey.currentContext?.findRenderObject() as RenderBox;
  RenderBox widgetBox =
      globalWidgetKey.currentContext?.findRenderObject() as RenderBox;
  return box.globalToLocal(widgetBox.localToGlobal(Offset.zero));
}

class FlowOutPin extends StatefulWidget {
  final String boxId, pinId;
  final void Function(String) addOutLink;
  const FlowOutPin(
      {super.key,
      required this.boxId,
      required this.pinId,
      required this.addOutLink});

  @override
  State<FlowOutPin> createState() => _FlowOutPinState();
}

class _FlowOutPinState extends State<FlowOutPin> {
  final Connections _connections = Connections.instance;
  String _tempLinkId = const Uuid().v1();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: _tempLinkId,
      rootOverlay: false,
      onDragStarted: () {
        _connections.create(_tempLinkId, widget.boxId, const Offset(1, 1),
            -_getPositionOfBox(_key));
      },
      onDragUpdate: (details) {
        _connections.create(
            _tempLinkId, widget.boxId, details.delta, details.localPosition);
      },
      onDragCompleted: () {
        widget.addOutLink(_tempLinkId);
        setState(() {
          _tempLinkId = const Uuid().v1();
        });
      },
      onDraggableCanceled: (velocity, offset) {
        _connections.linkList.remove(_tempLinkId);
      },
      feedback: Container(
        height: 10,
        width: 10,
        color: Colors.purple,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 10,
        width: 10,
        color: Colors.purple,
        child: SizedBox(
          key: _key,
        ),
      ),
    );
  }
}

class FlowInPin extends StatefulWidget {
  final String boxId, pinId;
  final void Function(String) addInLink;
  const FlowInPin(
      {super.key,
      required this.boxId,
      required this.pinId,
      required this.addInLink});

  @override
  State<FlowInPin> createState() => _FlowInPinState();
}

class _FlowInPinState extends State<FlowInPin> {
  final Connections _connections = Connections.instance;
  String _tempLinkId = const Uuid().v1();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAcceptWithDetails: (details) {
        widget.addInLink(details.data);
        _connections.onConnection(
            details.data, widget.boxId, -_getPositionOfBox(_key));
      },
      builder: (context, candidateItems, rejectedItems) {
        return Container(
          height: 10,
          width: 10,
          alignment: Alignment.center,
          color: Colors.yellowAccent,
          child: SizedBox(
            key: _key,
          ),
        );
      },
    );
  }
}
