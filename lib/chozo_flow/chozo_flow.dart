import 'dart:convert';
import 'dart:developer';
import 'package:chozo_ui_package/chozo_flow/add_function.dart';
import 'package:chozo_ui_package/chozo_flow/variable_pannel.dart';
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
                      "ipin": ["val"],
                      "opin": ["out"],
                      "ilinks": [],
                      "olinks": ["95e6ee19-ec52-4af0-a3e1-013462b2d317"],
                      "details": {
                        "id": "293bf027-ed6a-443e-8c19-4c17fb5b26a6",
                        "name": "Evaluation",
                        "color":
                            "MaterialColor(primary value: Color(alpha: 1.0000, red: 0.6196, green: 0.6196, blue: 0.6196, colorSpace: ColorSpace.sRGB))",
                        "type": "basic",
                        "refId": "eval",
                        "pos": {"x": 50, "y": 33}
                      },
                      "data": [
                        {"name": "Eval", "type": "eval", "value": ""}
                      ],
                      "userVar": []
                    },
                    {
                      "ipin": ["val"],
                      "opin": ["true", "false"],
                      "ilinks": [],
                      "olinks": [
                        "9b965083-da4d-4647-8673-fc9ed76963e6",
                        "7dc56d82-b668-4723-96ac-ea8c86ba047a"
                      ],
                      "details": {
                        "id": "68fb2eba-aca2-49c6-b92d-35034ea10034",
                        "name": "If",
                        "color":
                            "MaterialColor(primary value: Color(alpha: 1.0000, red: 0.6196, green: 0.6196, blue: 0.6196, colorSpace: ColorSpace.sRGB))",
                        "type": "basic",
                        "refId": "if",
                        "pos": {"x": 81, "y": 218}
                      },
                      "data": [
                        {"name": "Eval", "type": "eval", "value": ""}
                      ],
                      "userVar": []
                    },
                    {
                      "ipin": ["val"],
                      "opin": ["out"],
                      "ilinks": [
                        "95e6ee19-ec52-4af0-a3e1-013462b2d317",
                        "9b965083-da4d-4647-8673-fc9ed76963e6",
                        "7dc56d82-b668-4723-96ac-ea8c86ba047a"
                      ],
                      "olinks": [],
                      "details": {
                        "id": "69968004-6f1c-4a5a-8e74-2627f0645cff",
                        "name": "Ema",
                        "color":
                            "MaterialColor(primary value: Color(alpha: 1.0000, red: 0.6196, green: 0.6196, blue: 0.6196, colorSpace: ColorSpace.sRGB))",
                        "type": "basic",
                        "refId": "Ema",
                        "pos": {"x": 354, "y": 208}
                      },
                      "data": [
                        {"name": "Ema", "type": "number", "value": "erfreferf"}
                      ],
                      "userVar": []
                    }
                  ],
                  "links": [
                    {
                      "id": "95e6ee19-ec52-4af0-a3e1-013462b2d317",
                      "fpin": "out",
                      "fbox": "293bf027-ed6a-443e-8c19-4c17fb5b26a6",
                      "tpin": "val",
                      "tbox": "69968004-6f1c-4a5a-8e74-2627f0645cff",
                      "s": {"x": 252.5, "y": 69.5},
                      "e": {"x": 391.5, "y": 245}
                    },
                    {
                      "id": "9b965083-da4d-4647-8673-fc9ed76963e6",
                      "fpin": "false",
                      "fbox": "68fb2eba-aca2-49c6-b92d-35034ea10034",
                      "tpin": "val",
                      "tbox": "69968004-6f1c-4a5a-8e74-2627f0645cff",
                      "s": {"x": 283.5, "y": 303.5},
                      "e": {"x": 391.5, "y": 245}
                    },
                    {
                      "id": "7dc56d82-b668-4723-96ac-ea8c86ba047a",
                      "fpin": "true",
                      "fbox": "68fb2eba-aca2-49c6-b92d-35034ea10034",
                      "tpin": "val",
                      "tbox": "69968004-6f1c-4a5a-8e74-2627f0645cff",
                      "s": {"x": 283.5, "y": 254.5},
                      "e": {"x": 391.5, "y": 245}
                    }
                  ],
                  "vars": [
                    {
                      "id": "a817f5a0-a1bd-4da9-8ca5-023a360d0153",
                      "name": "ewd",
                      "type": "text",
                      "value": "dew",
                      "isPersistent": false,
                      "isImmutable": false
                    },
                    {
                      "id": "f3dd77bb-0eb6-4c4f-883b-20e98d8d991e",
                      "name": "var1dwe",
                      "type": "text",
                      "value": "dw3424",
                      "isPersistent": false,
                      "isImmutable": false
                    },
                    {
                      "id": "329d08a9-d2f3-4d51-ae22-20d7613769a8",
                      "name": "var2432432",
                      "type": "text",
                      "value": "",
                      "isPersistent": false,
                      "isImmutable": false
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

              // bottom menu
              Positioned(
                  bottom: 10,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 10,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  _connections.openedView = OpenedView.addBlock;
                                  _connections.refresh();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "+ Add Block",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  log("${json.encode(_connections.toJson())}");
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Print",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _connections.openedView =
                                      OpenedView.varPannel;
                                  _connections.refresh();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Storage",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),

              if (_connections.selectedId != null)
                Positioned.fill(
                    child: GestureDetector(
                  onTap: () {
                    _connections.selectedId = null;
                    _connections.openedView = OpenedView.none;
                    _connections.refresh();
                  },
                  child: Container(
                    color: const Color.fromARGB(117, 68, 68, 68),
                  ),
                )),
              if (_connections.selectedId != null)
                Center(
                    child: ConfigBox(
                  box: _connections.boxList[_connections.selectedId]!,
                )),

              Center(
                child: switch (_connections.openedView) {
                  // ignore: prefer_const_constructors
                  OpenedView.addBlock => AddFunction(),
                  // ignore: prefer_const_constructors
                  OpenedView.varPannel => VarPannel(),
                  OpenedView.none => const SizedBox()
                },
              )
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
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
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
