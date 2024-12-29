import 'package:flutter/material.dart';

import '../../chozo_flow/connections.dart';

class FlowInPin extends StatefulWidget {
  final String boxId, pinId;
  const FlowInPin({super.key, required this.boxId, required this.pinId});

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
        _connections.boxList[widget.boxId]?.inLinks.add(details.data);
        final Offset pinPos = _connections.getPosOfElement(_key);
        _connections.onConnection(
            details.data, widget.pinId, widget.boxId, pinPos);
      },

      builder: (context, candidateItems, rejectedItems) {
        return Container(
          height: 50,
          width: 45,
           color: const Color.fromARGB(0, 0, 0, 0),
          alignment: Alignment.centerRight,
          child: Container(
            height: 15,
            width: 15,
            alignment: Alignment.center,
            color: Colors.yellowAccent,
            child: SizedBox(
              key: _key,
            ),
          ),
        );
      },
    );
  }
}
