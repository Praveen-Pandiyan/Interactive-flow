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
  Connections _connections = Connections.instance;
  @override
  void initState() {
    _connections.addListener(() {
      setState(() {});
    });
     WidgetsBinding.instance.addPostFrameCallback((_) {
     RenderBox box =
                  key.currentContext?.findRenderObject() as RenderBox;
              Offset position =
                  box.globalToLocal(Offset.zero);
            _connections.setGlobalOffset(position);
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
      extendBody: true,
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        TextButton(
            onPressed: () {
              print("${controllerT.value.toString()}");
              controllerT.value = initialControllerValue!;
            },
            child: Text("edffe")),
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.black12, Colors.yellow])),
            child: GestureDetector(
              
           
              behavior: HitTestBehavior.translucent,
              child: DeferredPointerHandler(
                link: _deferredPointerLink,
                child: InteractiveViewer(
                  key: key,
                  boundaryMargin: const EdgeInsets.all(double.infinity),
                  
                  transformationController: controllerT,
                  onInteractionStart: (details) {
                    
                    initialControllerValue ??= controllerT.value;
                  },
                  onInteractionUpdate: (details) {
                    print(details.scale);
                     _connections.setGlobalOffset(details.focalPointDelta*(details.scale));
                     
                  },
                 
                  scaleEnabled: true,
                 
                  constrained: false,
                  child: Container(
                    color: Colors.transparent,
                    height: 200,
                    width: 200,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        DragableCom(
                            id: "23423423",
                            child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.red,
                                child: Text("data"))),
                        DragableCom(
                            id: "23423423",
                            child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.green,
                                child: Text("data"))),
                        DragableCom(
                            id: "23423423",
                            child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.black12,
                                child: Text("data"))),
                        DragableCom(
                            id: "scdcd",
                            child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.blue,
                                child: Text("data"))),
                        ..._connections.list.values.map((e) => CustomPaint(
                              painter: ArrowPainter(from: e.start, to: e.end),
                              child: Container(),
                            )),
                      ],
                    ),
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

class Indi extends StatelessWidget {
  const Indi({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.amber,
        child: Text("hello tjhere"),
      ),
    );
  }
}

class DragableCom extends StatefulWidget {
  final String id;
  final Widget child;
  const DragableCom({super.key, required this.child, required this.id});

  @override
  State<DragableCom> createState() => _DragableComState();
}

class _DragableComState extends State<DragableCom> {
  final Connections _connections = Connections.instance;
  Offset _localPos = const Offset(0, 0);
  List<String> inpLinks = [], outLinks = [];
  String _tempLinkId = const Uuid().v1();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _localPos.dy,
      left: _localPos.dx,
      child: DeferPointer(
        link: _deferredPointerLink,
        paintOnTop: false,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          DragTarget<String>(
            onAcceptWithDetails: (details) {
              inpLinks.add(details.data);
            },
            builder: (context, candidateItems, rejectedItems) {
              return Container(
                height: 10,
                width: 10,
                color: Colors.yellowAccent,
              );
            },
          ),
          GestureDetector(
            onTap: () {
                print("""inp :$inpLinks  out: $outLinks
              ${_connections.list}
              """);
              },
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
              Draggable<String>(
                data: _tempLinkId,
                rootOverlay: false,
                onDragUpdate: (details) {
                  _connections.create(_tempLinkId, details.delta, details.globalPosition);
                },
                onDragCompleted: () {
                  outLinks.add(_tempLinkId);
                 setState(() {
                    _tempLinkId = const Uuid().v1();
                 });
                },
                onDraggableCanceled: (velocity, offset) {
                  _connections.list.remove(_tempLinkId);
                },
                feedback: Container(
                  height: 10,
                  width: 10,
                  color: Colors.purple,
                ),
                child: Container(
                  
                  height: 10,
                  width: 10,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 30,),
              Draggable<String>(
                data: _tempLinkId,
                rootOverlay: false,
                onDragUpdate: (details) {
                  _connections.create(_tempLinkId, details.delta, details.globalPosition);
                },
                onDragCompleted: () {
                  outLinks.add(_tempLinkId);
                 setState(() {
                    _tempLinkId = const Uuid().v1();
                 });
                },
                onDraggableCanceled: (velocity, offset) {
                  _connections.list.remove(_tempLinkId);
                },
                feedback: Container(
                  height: 10,
                  width: 10,
                  color: Colors.purple,
                ),
                child: Container(
                  
                  height: 10,
                  width: 10,
                  color: Colors.purple,
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
