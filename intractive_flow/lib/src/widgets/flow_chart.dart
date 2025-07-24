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
  final TransformationController _transformationController = TransformationController();

  static const nodeWidth = 150.0;
  static const nodeHeight = 48.0;
  static const pinOffsetY = nodeHeight / 2;
  static const pinOffsetX = 0.0;

  Offset getPinPosition(FlowNode node, bool isInput) {
    final dx = node.position.dx + (isInput ? -8 : nodeWidth + 8);
    final dy = node.position.dy + pinOffsetY;
    return Offset(dx, dy);
  }

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
    return InteractiveViewer(
      transformationController: _transformationController,
      minScale: 0.2,
      maxScale: 2.5,
      boundaryMargin: const EdgeInsets.all(double.infinity),
      child: Stack(
        children: [
          // Draw permanent edges
          ...widget.controller.edges.values.map((edge) {
            final fromNode = widget.controller.nodes[edge.sourceNodeId];
            final toNode = widget.controller.nodes[edge.targetNodeId];
            if (fromNode == null || toNode == null) return const SizedBox();
            final from = getPinPosition(fromNode, false);
            final to = getPinPosition(toNode, true);
            return CustomPaint(
              painter: EdgePainter(from: from, to: to),
            );
          }),
          // Draw temporary (dragging) edges
          ...widget.controller.tempEdges.values.map((tempEdge) {
            return CustomPaint(
              painter: EdgePainter(from: tempEdge.start, to: tempEdge.end, color: Colors.blueAccent),
            );
          }),
          // Draw nodes
          ...widget.controller.nodes.values.map((node) => Positioned(
                left: node.position.dx,
                top: node.position.dy,
                child: NodeWidget(
                  node: node,
                  controller: widget.controller,
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