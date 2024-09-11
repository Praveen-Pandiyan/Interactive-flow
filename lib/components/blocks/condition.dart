import 'package:flutter/material.dart';

import '../../chozo_flow/connections.dart';

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
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        child: Column(
          children: [
            ..._connections.boxList[widget.boxId]!.data
                .map((e) => Text("${e.name}: ${e.value}")),
            Text("Evaluation"),
         
          ],
        ),
      ),
     
    ]);
  }
}
