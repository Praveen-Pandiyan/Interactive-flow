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
  String _tempLinkId = const Uuid().v1();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: _tempLinkId,
      rootOverlay: false,
      onDragStarted: () {
        final Offset pinPos = _connections.getPosOfElement(_key);
        _connections.create(_tempLinkId, widget.pinId,widget.boxId, Offset.zero, pinPos);
      },
      onDragUpdate: (details) {
        _connections.create(
            _tempLinkId, widget.pinId,widget.boxId, details.delta, details.globalPosition);
      },
      onDragCompleted: () { 
        _connections.boxList[widget.boxId]?.outLinks.add(_tempLinkId);
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
