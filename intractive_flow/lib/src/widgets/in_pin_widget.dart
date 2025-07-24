import 'package:flutter/material.dart';
import '../core/flow_controller.dart';

class InPinWidget extends StatefulWidget {
  final String nodeId, pinId;
  final FlowController controller;
  const InPinWidget({Key? key, required this.nodeId, required this.pinId, required this.controller}) : super(key: key);

  @override
  State<InPinWidget> createState() => _InPinWidgetState();
}

class _InPinWidgetState extends State<InPinWidget> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAcceptWithDetails: (details) {
        widget.controller.addEdgeFromDrag(details.data, widget.nodeId, widget.pinId, _key);
      },
      builder: (context, candidateItems, rejectedItems) {
        return Container(
          height: 50,
          width: 45,
          color: Colors.transparent,
          alignment: Alignment.centerRight,
          child: Container(
            height: 15,
            width: 15,
            alignment: Alignment.center,
            color: Colors.yellowAccent,
            child: SizedBox(key: _key),
          ),
        );
      },
    );
  }
} 