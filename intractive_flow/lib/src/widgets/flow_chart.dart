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
          // Draw permanent edges connecting to individual pins
          ...widget.controller.edges.values.map((edge) {
            final fromPosition = widget.controller.getEdgeSourcePosition(edge);
            final toPosition = widget.controller.getEdgeTargetPosition(edge);
            
            if (fromPosition == null || toPosition == null) return const SizedBox();
            
            return CustomPaint(
              painter: EdgePainter(from: fromPosition, to: toPosition),
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