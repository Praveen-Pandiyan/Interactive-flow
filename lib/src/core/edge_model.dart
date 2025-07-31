/// Model representing an edge (connection) between two nodes in the flow chart.
class FlowEdge {
  final String id;
  final String sourceNodeId;
  final String sourcePinId;
  final String targetNodeId;
  final String targetPinId;

  FlowEdge({
    required this.id,
    required this.sourceNodeId,
    required this.sourcePinId,
    required this.targetNodeId,
    required this.targetPinId,
  });
} 