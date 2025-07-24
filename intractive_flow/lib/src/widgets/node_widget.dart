import 'package:flutter/material.dart';
import '../core/node_model.dart';
import 'in_pin_widget.dart';
import 'out_pin_widget.dart';
import '../core/flow_controller.dart';

class NodeWidget extends StatelessWidget {
  final FlowNode node;
  final FlowController controller;
  final VoidCallback? onTap;
  final Function(Offset)? onDrag;

  const NodeWidget({Key? key, required this.node, required this.controller, this.onTap, this.onDrag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onPanUpdate: (details) {
        if (onDrag != null) {
          onDrag!(details.delta);
        }
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: node.color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input pins
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...node.inputPins.map((e) => InPinWidget(nodeId: node.id, pinId: e, controller: controller)),
              ],
            ),
            // Node content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(node.label, style: Theme.of(context).textTheme.titleMedium),
                  // TODO: Add custom content
                ],
              ),
            ),
            // Output pins
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...node.outputPins.map((e) => OutPinWidget(nodeId: node.id, pinId: e, controller: controller)),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 