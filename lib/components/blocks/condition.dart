import 'package:chozo_ui_package/components/inputs/eval.dart';
import 'package:flutter/material.dart';

import '../../chozo_flow/connections.dart';
import '../inputs/input_box.dart';
import '../pins/pins.dart';

class Condition extends StatefulWidget {
  final String boxId;
  final List<String> inPins, outPins;
  const Condition({
    super.key,
    required this.boxId,
    required this.inPins,
    required this.outPins,
  });

  @override
  State<Condition> createState() => _ConditionState();
}

class _ConditionState extends State<Condition> {
  final Connections _connections = Connections.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ...widget.inPins.map((e) => FlowInPin(
                  boxId: widget.boxId,
                  pinId: e,
                )),
            Text(" :Value")
          ],
        ),
        // ..._connections.boxList[widget.boxId]!.data.map((e) => InputBox(
        //       boxId: widget.boxId,
        //       data: e,
        //     )),
        Text("Evaluation"),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("True"),
            FlowOutPin(boxId: widget.boxId),
          ],
        ),
        Row(
           mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("False"),
            FlowOutPin(boxId: widget.boxId),
          ],
        )
      ],
    );
  }
}
