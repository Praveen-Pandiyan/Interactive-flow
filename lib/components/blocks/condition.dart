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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_connections.boxList[widget.boxId]!.userVar != null) ...[
            Text(
              "Variables",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            ...?_connections.boxList[widget.boxId]!.userVar?.map((e) => Text(
                  "${e.name}: ${e.value}",
                  style: Theme.of(context).textTheme.labelSmall,
                )),
          ],
          const SizedBox(height: 10),
          if (_connections.boxList[widget.boxId]!.userVar != null) ...[
            Text(
              "Inputs",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ..._connections.boxList[widget.boxId]!.data.map((e) => Text(
              "${e.name}: ${e.value}",
              style: Theme.of(context).textTheme.labelSmall)),]
    
        ],
      ),
    );
  }
}
