import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
  // Map<String, Connection> _cooectionList = {
  //   "ggg": Connection(id: "ggg", start: Offset(100, 100), end: Offset(456, 345))
  // };
  final Connections _connections = Connections.instance;
  Offset _globalOffset = Offset.zero;
 

  Offset getOffsetFromMatrix(Matrix4 matrix) {
    // Extract the translation values from the matrix
    final translation = matrix.getTranslation();
    return Offset(translation.x, translation.y);
  }

  _initCalibratePosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
      Offset position = box.globalToLocal(Offset.zero);
      _globalOffset = position;
      _connections.setGlobalOffset(position);
    });
  }

  _calibratePosition() {
    _connections.globalOffset =
        _globalOffset - (getOffsetFromMatrix(controllerT.value));
  }

  _resetScale() {
   
    setState(() {
      final matrix = initialControllerValue!.clone();
      final translation = matrix.getTranslation();
      
      controllerT.value = Matrix4.identity()
        ..translate(translation.x, translation.y)
        ..scale(1.0);

    });
  

  }

  @override
  void initState() {
    _connections.addListener(() {
      setState(() {});
    });
    _initCalibratePosition();
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
                  print("${controllerT.value.toString()}");
                  controllerT.value = initialControllerValue!;
                },
                child: Text("center")),
            TextButton(
                onPressed: () {
                  _connections.addNewBox();
                },
                child: Text("add new")),
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
                transformationController: controllerT,
                onInteractionStart: (details) {
                  _calibratePosition();
                  initialControllerValue ??= controllerT.value.clone();
                 
                },
                onInteractionUpdate: (details) {
                  _connections.setGlobalOffset(details.focalPointDelta);
                  print("${controllerT.value}");
                  
                },
                onInteractionEnd: (details) {
                  _calibratePosition();
                  // _resetScale();
                },
                scaleEnabled: true,
                
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
                              width: 100,
                              height: 100,
                              color: Colors.red,
                              child: Text("data"))))
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
  final List<String>? inLinks, outLinks;
  final Widget child;
  const FlowContainer(
      {super.key,
      required this.child,
      this.initialPos = Offset.zero,
      this.inPins,
      this.outPins,
      this.inLinks,
      this.outLinks,
      required this.id});

  @override
  State<FlowContainer> createState() => _FlowContainerState();
}

class _FlowContainerState extends State<FlowContainer> {
  final Connections _connections = Connections.instance;
  Offset _localPos = const Offset(0, 0);
  List<String> inpLinks = [], outLinks = [];
// temp
  @override
  void initState() {
    _localPos = widget.initialPos;
    inpLinks = widget.inLinks ?? [];
    outLinks = widget.outLinks ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _localPos.dy,
      left: _localPos.dx,
      child: DeferPointer(
        link: _deferredPointerLink,
        paintOnTop: false,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          // todo: dynamic pins
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
            child: widget.child,
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
        ]),
      ),
    );
  }
}

_getPositionOfBox(GlobalKey inKey) {
  RenderBox box = inKey.currentContext?.findRenderObject() as RenderBox;
  return box.globalToLocal(Offset.zero);
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
