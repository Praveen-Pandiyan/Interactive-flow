import 'package:example/chozo_flow/connections.dart';
import 'package:flutter/material.dart';
import 'package:defer_pointer/defer_pointer.dart';

final _deferredPointerLink = DeferredPointerHandlerLink();






class ChozoFlow extends StatefulWidget {
  const ChozoFlow({super.key});

  @override
  State<ChozoFlow> createState() => _ChozoFlowState();
}

class _ChozoFlowState extends State<ChozoFlow> {
  int _counter = 0;
  Offset _offGreen = Offset(0, 0);
  Offset _offRed = Offset(0, 0);
  AppBar _appBar = AppBar(
    title: Text('Drag'),
    leading: BackButton(onPressed: () {}),
  );
  TransformationController controllerT = TransformationController();
  Matrix4? initialControllerValue;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () {
                  print("${controllerT.value.toString()}");
                  controllerT.value = initialControllerValue!;
                },
                child: Text("edffe")),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.red, Colors.black12, Colors.yellow])),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: DeferredPointerHandler(
                    link: _deferredPointerLink,
                    child: InteractiveViewer(
                      boundaryMargin: EdgeInsets.all(double.infinity),
                      minScale: 0.1,
                      transformationController: controllerT,
                      onInteractionStart: (details) {
                        initialControllerValue ??= controllerT.value;
                      },
                      scaleEnabled: false,
                      maxScale: 5.0,
                      constrained: false,
                      child: Container(
                        color: Colors.transparent,
                        height: 200,
                        width: 200,
                        child: Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                               DragableCom(),
                              DragableCom(),
                              DragableCom(),
                              CustomPaint(painter: ArrowPainter(from: Offset(100, 100), to: Offset(304, 564)),child: Container(),),
                              // draggable(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
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
  const DragableCom({super.key});

  @override
  State<DragableCom> createState() => _DragableComState();
}

class _DragableComState extends State<DragableCom> {
  Offset _offRed = Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _offRed.dy,
      left: _offRed.dx,
      child: DeferPointer(
        link: _deferredPointerLink,
        paintOnTop: false,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DragTarget<Connection>(
              onAcceptWithDetails: (details) {
                print(details.data);
              },
              builder: (context, candidateItems, rejectedItems) {
                return SizedBox(
                  child: Text(" hello"),
                );
              },
            ),
            Draggable(
              rootOverlay: false,
              onDragUpdate: (details) {
                print("${details.localPosition.toString()}  ${details.globalPosition.toString()}");
                setState(() {
                  _offRed = _offRed + details.delta;
                });
              },
              feedback: Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
                child: Text("Big red"),
              ),
            ),

            Draggable<Connection>(
              data: Connection(id: "hellonthere from out"),
              rootOverlay: false,
              onDragUpdate: (details) {
                print(details.localPosition.toString());
                
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
          ],
        ),
      ),
    );
  }
}

class Connection {
  final String id;
  const Connection({required this.id});
}
