import 'package:flutter/material.dart';
import '../core/flow_controller.dart';
import '../core/node_model.dart';
import '../core/edge_model.dart';
import 'node_widget.dart';
import 'edge_painter.dart';

/// The main interactive flow chart widget.
///
/// Use [FlowChart] to display and interact with nodes and connections.
class FlowChart extends StatefulWidget {
  final FlowController controller;
  const FlowChart({Key? key, required this.controller}) : super(key: key);

  @override
  State<FlowChart> createState() => _FlowChartState();
}

class _FlowChartState extends State<FlowChart> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerUpdate);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerUpdate);
    super.dispose();
  }

  void _onControllerUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Stack(
        children: [
          // Draw edges
          ...widget.controller.edges.values.map((edge) {
            final fromNode = widget.controller.nodes[edge.sourceNodeId];
            final toNode = widget.controller.nodes[edge.targetNodeId];
            if (fromNode == null || toNode == null) return const SizedBox();
            // For simplicity, use node center as pin position
            final from = fromNode.position + const Offset(75, 25);
            final to = toNode.position + const Offset(75, 25);
            return CustomPaint(
              painter: EdgePainter(from: from, to: to),
            );
          }),
          // Draw nodes
          ...widget.controller.nodes.values.map((node) => Positioned(
                left: node.position.dx,
                top: node.position.dy,
                child: NodeWidget(
                  node: node,
                  onDrag: (delta) {
                    setState(() {
                      node.position += delta;
                      widget.controller.updateNode(node);
                    });
                  },
                ),
              )),
        ],
      ),
    );
  }
} 