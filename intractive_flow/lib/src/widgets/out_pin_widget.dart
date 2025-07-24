import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../core/flow_controller.dart';

class OutPinWidget extends StatefulWidget {
  final String nodeId, pinId;
  final FlowController controller;
  const OutPinWidget({Key? key, required this.nodeId, required this.pinId, required this.controller}) : super(key: key);

  @override
  State<OutPinWidget> createState() => _OutPinWidgetState();
}

class _OutPinWidgetState extends State<OutPinWidget> {
  String _tempEdgeId = const Uuid().v4();
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: _tempEdgeId,
      rootOverlay: false,
      onDragStarted: () {
        widget.controller.startEdgeDrag(_tempEdgeId, widget.nodeId, widget.pinId, _key);
      },
      onDragUpdate: (details) {
        widget.controller.updateEdgeDrag(_tempEdgeId, details.globalPosition);
      },
      onDragCompleted: () {
        widget.controller.finalizeEdgeDrag(_tempEdgeId, widget.nodeId);
        if (mounted) {
          setState(() {
            _tempEdgeId = const Uuid().v4();
          });
        }
      },
      onDraggableCanceled: (velocity, offset) {
        widget.controller.cancelEdgeDrag(_tempEdgeId);
      },
      feedback: Container(
        height: 15,
        width: 15,
        color: Colors.purple,
      ),
      child: Container(
        height: 35,
        width: 45,
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        child: Container(
          alignment: Alignment.center,
          height: 15,
          width: 15,
          color: Colors.purple,
          child: SizedBox(key: _key),
        ),
      ),
    );
  }
} 