import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../chozo_flow/connections.dart';

class FlowOutPin extends StatefulWidget {
  final String boxId, pinId;
  const FlowOutPin({super.key, required this.pinId, required this.boxId});

  @override
  State<FlowOutPin> createState() => _FlowOutPinState();
}

class _FlowOutPinState extends State<FlowOutPin> {
  final Connections _connections = Connections.instance;
  String _tempLinkId = const Uuid().v4();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: _tempLinkId,
      rootOverlay: false,

      onDragStarted: () {
        final Offset pinPos = _connections.getPosOfElement(_key);
        _connections.create(
            _tempLinkId, widget.pinId, widget.boxId, Offset.zero, pinPos);
      },
      onDragUpdate: (details) {
        _connections.create(_tempLinkId, widget.pinId, widget.boxId,
            details.delta, details.globalPosition);
      },
      onDragCompleted: () {
        _connections.boxList[widget.boxId]?.outLinks.add(_tempLinkId);
        setState(() {
          _tempLinkId = const Uuid().v4();
        });
      },
      onDraggableCanceled: (velocity, offset) {
        _connections.linkList.remove(_tempLinkId);
      },
      feedback: Container(
        height: 15,
        width: 15,
        color: Colors.purple,
      ),
      child: Container(
        height: 35,
        width: 45,
        color: const Color.fromARGB(0, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Container(
          alignment: Alignment.center,
          height: 15,
          width: 15,
          color: Colors.purple,
          child: SizedBox(
            key: _key,
          ),
        ),
      ),
    );
  }
}
