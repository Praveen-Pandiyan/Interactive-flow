import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:uuid/uuid.dart';
import 'connections.dart';

final _deferredPointerLink = DeferredPointerHandlerLink();

class ChozoFlow extends StatefulWidget {
  const ChozoFlow({super.key});

  @override
  State<ChozoFlow> createState() => _ChozoFlowState();
}

class _ChozoFlowState extends State<ChozoFlow> {
  TransformationController controllerT = TransformationController();
  Matrix4? initialControllerValue;
  GlobalKey key = GlobalKey();
  final Connections _connections = Connections.instance;

  @override
  void initState() {
    _connections.addListener(() {
      setState(() {});
    });
    _connections.viewerPosition = controllerT;
    _connections.key = key;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag'),
        leading: BackButton(onPressed: () {}),
      ),
      extendBody: false,
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  controllerT.value = initialControllerValue!;
                },
                child: Text("center")),
            TextButton(
                onPressed: () {
                  _connections.addNewBox();
                },
                child: Text("add new")),
            TextButton(
                onPressed: () {
                  log(json.encode(_connections.toJson()));
                },
                child: Text("print")),
            TextButton(
                onPressed: () {
                  print(_connections.loadFlow({
                    "id": "dferf",
                    "name": "chumma",
                    "boxs": [
                      {
                        "id": "613f44e0-52fb-11ef-8213-d7a6f2e92a6a",
                        "ipin": ["srfreg", "dewf"],
                        "opin": ["frwfef", "fer"],
                        "refId": "cdfc",
                        "ilinks": [],
                        "olinks": [
                          "61438aa0-52fb-11ef-8213-d7a6f2e92a6a",
                          "6143d8c0-52fb-11ef-8213-d7a6f2e92a6a",
                          "69f7a140-52fb-11ef-8213-d7a6f2e92a6a"
                        ],
                        "pos": {"x": -8.75, "y": 237.5},
                        "data": [
                          {"name": "ema", "type": "number", "value": ""},
                          {"name": "sma", "type": "number", "value": ""}
                        ]
                      },
                      {
                        "id": "6222a000-52fb-11ef-8213-d7a6f2e92a6a",
                        "ipin": ["srfreg", "dewf"],
                        "opin": ["frwfef", "fer"],
                        "refId": "cdfc",
                        "ilinks": [
                          "61438aa0-52fb-11ef-8213-d7a6f2e92a6a",
                          "62938a40-52fb-11ef-8213-d7a6f2e92a6a"
                        ],
                        "olinks": [],
                        "pos": {"x": 326.5, "y": 444.25},
                        "data": [
                          {"name": "ema", "type": "number", "value": ""},
                          {"name": "sma", "type": "number", "value": ""}
                        ]
                      },
                      {
                        "id": "628fe0c0-52fb-11ef-8213-d7a6f2e92a6a",
                        "ipin": ["srfreg", "dewf"],
                        "opin": ["frwfef", "fer"],
                        "refId": "cdfc",
                        "ilinks": [
                          "6143d8c0-52fb-11ef-8213-d7a6f2e92a6a",
                          "69f7a140-52fb-11ef-8213-d7a6f2e92a6a"
                        ],
                        "olinks": ["62938a40-52fb-11ef-8213-d7a6f2e92a6a"],
                        "pos": {"x": 394.25, "y": 186},
                        "data": [
                          {"name": "ema", "type": "number", "value": ""},
                          {"name": "sma", "type": "number", "value": ""}
                        ]
                      }
                    ],
                    "links": [
                      {
                        "id": "61438aa0-52fb-11ef-8213-d7a6f2e92a6a",
                        "fpin": "613f44e0-52fb-11ef-8213-d7a6f2e92a6a",
                        "tpin": "6222a000-52fb-11ef-8213-d7a6f2e92a6a",
                        "s": {"x": 206.25, "y": 252.5},
                        "e": {"x": 331.5, "y": 459.25}
                      },
                      {
                        "id": "6143d8c0-52fb-11ef-8213-d7a6f2e92a6a",
                        "fpin": "613f44e0-52fb-11ef-8213-d7a6f2e92a6a",
                        "tpin": "628fe0c0-52fb-11ef-8213-d7a6f2e92a6a",
                        "s": {"x": 206.25, "y": 282.5},
                        "e": {"x": 399.25, "y": 201}
                      },
                      {
                        "id": "62938a40-52fb-11ef-8213-d7a6f2e92a6a",
                        "fpin": "628fe0c0-52fb-11ef-8213-d7a6f2e92a6a",
                        "tpin": "6222a000-52fb-11ef-8213-d7a6f2e92a6a",
                        "s": {"x": 609.25, "y": 231},
                        "e": {"x": 331.5, "y": 489.25}
                      },
                      {
                        "id": "69f7a140-52fb-11ef-8213-d7a6f2e92a6a",
                        "fpin": "613f44e0-52fb-11ef-8213-d7a6f2e92a6a",
                        "tpin": "628fe0c0-52fb-11ef-8213-d7a6f2e92a6a",
                        "s": {"x": 206.25, "y": 282.5},
                        "e": {"x": 399.25, "y": 231}
                      }
                    ],
                    "cversion": "0.0.1",
                    "version": "23432443"
                  }));
                },
                child: Text("load")),
          ],
        ),
        Expanded(
          flex: 1,
          child: Container(
            key: key,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.black12, Colors.yellow])),
            child: DeferredPointerHandler(
              link: _deferredPointerLink,
              child: InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(double.infinity),
                scaleEnabled: true,
                transformationController: controllerT,
                onInteractionStart: (details) {
                  initialControllerValue ??= controllerT.value.clone();
                },
                onInteractionUpdate: (details) {},
                onInteractionEnd: (details) {},
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      ..._connections.linkList.values.map((e) => CustomPaint(
                            painter: ArrowPainter(from: e.start, to: e.end),
                            child: Container(),
                          )),
                      ..._connections.boxList.values.map((e) => FlowContainer(
                          id: e.id,
                          inPins: e.inPins,
                          outPins: e.outPins,
                          initialPos: e.pos,
                          key: Key(e.id),
                          child: Container(
                              constraints: BoxConstraints(maxWidth: 200),
                              color: Colors.red,
                              child: Column(
                                children: [
                                  ...e.data.map((e) => Row(
                                        children: [
                                          Text(
                                              "${e.name} : ${e.value.toString()}"),
                                        ],
                                      ))
                                    ..toList()
                                ],
                              ))))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class DottedPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    const double dotRadius = 2.0;
    const double spacing = 20.0;

    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class FlowContainer extends StatefulWidget {
  final String id;
  final Offset initialPos;
  final List<String>? inPins, outPins;
  final Widget child;
  const FlowContainer(
      {super.key,
      required this.child,
      this.initialPos = Offset.zero,
      this.inPins,
      this.outPins,
      required this.id});

  @override
  State<FlowContainer> createState() => _FlowContainerState();
}

class _FlowContainerState extends State<FlowContainer> {
  final Connections _connections = Connections.instance;
  Offset _localPos = const Offset(0, 0);
  final GlobalKey _key = GlobalKey();
  // these are pin / edges for this node
  List<String> inPins = [], outPins = [];
// temp
  @override
  void initState() {
    _localPos = widget.initialPos;

    // for pins
    inPins = widget.inPins ?? [];
    outPins = widget.outPins ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: _key,
      top: _localPos.dy,
      left: _localPos.dx,
      child: DeferPointer(
        link: _deferredPointerLink,
        paintOnTop: false,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // todo: dynamic pins
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              ...inPins.map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FlowInPin(
                    boxId: widget.id,
                    pinId: e,
                    parentKey: _key,
                    parentOffset: _localPos,
                    addInLink: (id) {
                      _connections.boxList[widget.id]?.inLinks.add(id);
                    },
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _localPos = _localPos + details.delta;
              });
              _connections.positionUpdate(
                  widget.id,
                  _localPos,
                  details.delta,
                  _connections.boxList[widget.id]!.inLinks,
                  _connections.boxList[widget.id]?.outLinks);
            },
            child: widget.child,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              ...outPins.map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: FlowOutPin(
                    boxId: widget.id,
                    pinId: e,
                    parentKey: _key,
                    parentOffset: _localPos,
                    addOutLink: (id) {
                      _connections.boxList[widget.id]?.outLinks.add(id);
                    },
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class FlowOutPin extends StatefulWidget {
  final String boxId, pinId;
  final void Function(String) addOutLink;
  final Offset parentOffset;
  final GlobalKey parentKey;
  const FlowOutPin(
      {super.key,
      required this.boxId,
      required this.pinId,
      required this.addOutLink,
      required this.parentOffset,
      required this.parentKey});

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
        final Offset pinPos = _connections.getPosOfElement(_key);
        _connections.create(_tempLinkId, widget.boxId, Offset.zero, pinPos);
      },
      onDragUpdate: (details) {
        _connections.create(
            _tempLinkId, widget.boxId, details.delta, details.globalPosition);
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
  final Offset parentOffset;
  final GlobalKey parentKey;
  final void Function(String) addInLink;
  const FlowInPin(
      {super.key,
      required this.boxId,
      required this.pinId,
      required this.addInLink,
      required this.parentOffset,
      required this.parentKey});

  @override
  State<FlowInPin> createState() => _FlowInPinState();
}

class _FlowInPinState extends State<FlowInPin> {
  final Connections _connections = Connections.instance;
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAcceptWithDetails: (details) {
        widget.addInLink(details.data);
        final Offset pinPos = _connections.getPosOfElement(_key);
        _connections.onConnection(details.data, widget.boxId, pinPos);
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

class Pin {
  final String boxID;
  final String id;
  GlobalKey key;

  Pin({required this.boxID, required this.id, required this.key});
}









// class FlowLine extends StatefulWidget {
//   final String likeId;
//   final Connections connections;
//   final void Function()? onDragStarted,onDragCompleted;
//   final void Function(DragUpdateDetails)? onDragUpdate;
//   final void Function(Velocity, Offset)? onDraggableCanceled;
//   const FlowLine({super.key, required this.likeId, required this.connections, this.onDragStarted, this.onDragCompleted, this.onDragUpdate, this.onDraggableCanceled});

//   @override
//   State<FlowLine> createState() => _FlowLineState();
// }

// class _FlowLineState extends State<FlowLine> {

//   GlobalKey key = GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return Draggable<String>(
//                 data: widget.likeId,
//                 rootOverlay: false,
//                 onDragUpdate: (details) {
//                 widget.onDragUpdate?.call(details);
//                 },
//                 onDragCompleted: () {

//                 },
//                 onDraggableCanceled: (velocity, offset) {

//                 },
//                 feedback: Container(
//                   height: 10,
//                   width: 10,
//                   color: Colors.purple,
//                 ),
//                 child: Container(
//                   height: 10,
//                   width: 10,
//                   color: Colors.purple,
//                 ),
//               ),;
//   }
// }
