import 'package:flutter/material.dart';
import '../core/node_model.dart';

class NodeWidget extends StatelessWidget {
  final FlowNode node;
  final VoidCallback? onTap;
  final Function(Offset)? onDrag;

  const NodeWidget({Key? key, required this.node, this.onTap, this.onDrag}) : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(node.label, style: Theme.of(context).textTheme.titleMedium),
            // TODO: Add pin widgets and custom content
          ],
        ),
      ),
    );
  }
} 