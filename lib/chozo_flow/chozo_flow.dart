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
  // Map<String, Connection> _cooectionList = {
  //   "ggg": Connection(id: "ggg", start: Offset(100, 100), end: Offset(456, 345))
  // };
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
                // minScale: 1,
                // maxScale: 1,
                boundaryMargin: const EdgeInsets.all(double.infinity),
                transformationController: controllerT,
                onInteractionStart: (details) {
                  initialControllerValue ??= controllerT.value.clone();
                },
                onInteractionUpdate: (details) {
                  // _connections.setGlobalOffset(details.focalPointDelta);
                  print("${details.scale}");
                  print("${controllerT.value}");
                },
                onInteractionEnd: (details) {
                  // _resetScale();
                },
                // scaleEnabled: false,
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
                                          Text(e.name),
                                          Expanded(child: TextField())
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
  final GlobalKey _key = GlobalKey();
  // these are links to other nodes
  List<String> inpLinks = [], outLinks = [];
  // these are pin / edges for this node
  List<String> inPins = [], outPins = [];
// temp
  @override
  void initState() {
    _localPos = widget.initialPos;
    inpLinks = widget.inLinks ?? [];
    outLinks = widget.outLinks ?? [];
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
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          // todo: dynamic pins
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...inPins.map(
                (e) => FlowInPin(
                  boxId: widget.id,
                  pinId: e,
                  parentKey: _key,
                  parentOffset: _localPos,
                  addInLink: inpLinks.add,
                ),
              )
            ],
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
              ...outPins.map(
                (e) => FlowOutPin(
                  boxId: widget.id,
                  pinId: e,
                  parentKey: _key,
                  parentOffset: _localPos,
                  addOutLink: outLinks.add,
                ),
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
  return box.localToGlobal(Offset.zero);
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
        final Offset pinPos = _getPositionOfBox(_key);
        final Offset boxPos = _getPositionOfBox(widget.parentKey);
        _connections.create(_tempLinkId, widget.boxId, const Offset(1, 1),
            widget.parentOffset - (boxPos - pinPos));
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
        final Offset pinPos = _getPositionOfBox(_key);
        final Offset boxPos = _getPositionOfBox(widget.parentKey);
        _connections.onConnection(details.data, widget.boxId,
            widget.parentOffset - (boxPos - pinPos));
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
