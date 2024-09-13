import 'dart:convert';
import 'dart:developer';
import 'package:chozo_ui_package/components/blocks/condition.dart';
import 'package:chozo_ui_package/components/inputs/eval.dart';
import 'package:flutter/material.dart';
import 'package:defer_pointer/defer_pointer.dart';
import '../components/pins/pins.dart';
import 'config_box.dart';
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
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          TextButton(
              onPressed: () {
                controllerT.value = initialControllerValue!;
              },
              child: const Text("center")),
          TextButton(
              onPressed: () {
                _connections.addNewBox();
              },
              child: const Text("add new")),
          TextButton(
              onPressed: () {
                log(json.encode(_connections.toJson()));
              },
              child: const Text("print")),
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
              child: const Text("load")),
        ],
      ),
      const EvalBox(onChange: print, onError: print),

      Expanded(
        flex: 1,
        child: Container(
          key: key,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.black12, Colors.yellow])),
          child: Stack(
            children: [
              DeferredPointerHandler(
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
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      ..._connections.linkList.values.map((e) => CustomPaint(
                            painter: ArrowPainter(from: e.start, to: e.end),
                            child: const SizedBox(),
                          )),
                      ..._connections.boxList.values.map((e) => FlowContainer(
                            id: e.details.id,
                            inPins: e.inPins,
                            outPins: e.outPins,
                            initialPos: e.details.pos,
                            key: Key(e.details.id),
                          )),
                    ],
                  ),
                ),
              ),
              if (_connections.selectedId != null)
                Center(
                    child: ConfigBox(
                  box: _connections.boxList[_connections.selectedId]!,
                ))
            ],
          ),
        ),
      ),

      // Box config
    ]);
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
  const FlowContainer(
      {super.key,
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
        
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...?widget.inPins?.map((e) => FlowInPin(
                        boxId: widget.id,
                        pinId: e,
                      )),
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _connections.secondarySelectedId = widget.id;
                _connections.refresh();
              },
              onDoubleTap: () {
                _connections.selectedId = widget.id;
                _connections.refresh();
              },
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
              child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: _connections.secondarySelectedId == widget.id
                            ? Colors.blue
                            : Colors.grey),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(5),topRight: Radius.circular(5) ),
                            color: _connections
                                    .boxList[widget.id]?.details.color ??
                                Colors.grey),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,

                          children: [
                            Text(
                                "${_connections.boxList[widget.id]?.details.name}"),
                          ],
                        ),
                      ),
                      Condition(
                          boxId: widget.id, inPins: inPins, outPins: outPins),
                    ],
                  )),
            ),
            Padding(
               padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...?widget.outPins?.map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: FlowOutPin(
                          boxId: widget.id,
                          pinId: e,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
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
