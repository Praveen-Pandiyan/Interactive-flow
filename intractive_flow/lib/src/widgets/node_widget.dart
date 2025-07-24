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

  const NodeWidget({super.key, required this.node, required this.controller, this.onTap, this.onDrag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onPanUpdate: (details) {
        if (onDrag != null) {
          onDrag!(details.delta);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            decoration: BoxDecoration(
              color: node.color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Text(node.label, style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
          // Input pin (left, vertically centered)
          Positioned(
            
            left: 0,
            child: InPinWidget(nodeId: node.id, pinId: 'in', controller: controller),
          ),
          // Output pin (right, vertically centered)
          Positioned(
            right: 0,
            child: OutPinWidget(nodeId: node.id, pinId: 'out', controller: controller),
          ),
        ],
      ),
    );
  }
} 