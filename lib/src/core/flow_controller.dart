import 'package:flutter/material.dart';
import 'node_model.dart';
import 'edge_model.dart';

class TempEdge {
  final String id;
  final String fromNodeId;
  final String fromPinId;
  Offset start;
  Offset end;
  TempEdge({required this.id, required this.fromNodeId, required this.fromPinId, required this.start, required this.end});
}

/// Controller for managing the state and logic of the interactive flow chart.
class FlowController extends ChangeNotifier {
  final Map<String, FlowNode> nodes = {};
  final Map<String, FlowEdge> edges = {};
  final Map<String, TempEdge> tempEdges = {};

  FlowController();

  void addNode(FlowNode node) {
    nodes[node.id] = node;
    notifyListeners();
  }

  void removeNode(String nodeId) {
    nodes.remove(nodeId);
    // Remove edges connected to this node
    edges.removeWhere((_, edge) => edge.sourceNodeId == nodeId || edge.targetNodeId == nodeId);
    notifyListeners();
  }

  void updateNode(FlowNode node) {
    nodes[node.id] = node;
    notifyListeners();
  }

  void addEdge(FlowEdge edge) {
    edges[edge.id] = edge;
    notifyListeners();
  }

  void removeEdge(String edgeId) {
    edges.remove(edgeId);
    notifyListeners();
  }

  void updateEdge(FlowEdge edge) {
    edges[edge.id] = edge;
    notifyListeners();
  }

  /// Get the absolute position of a pin
  Offset? getPinPosition(String nodeId, String pinId) {
    final node = nodes[nodeId];
    if (node == null) return null;
    
    final pin = node.getPin(pinId);
    if (pin == null) return null;
    
    return pin.getAbsolutePosition(node.position);
  }

  /// Get the source pin position for an edge
  Offset? getEdgeSourcePosition(FlowEdge edge) {
    return getPinPosition(edge.sourceNodeId, edge.sourcePinId);
  }

  /// Get the target pin position for an edge
  Offset? getEdgeTargetPosition(FlowEdge edge) {
    return getPinPosition(edge.targetNodeId, edge.targetPinId);
  }

  // Interactive connection logic
  void startEdgeDrag(String edgeId, String fromNodeId, String fromPinId, GlobalKey pinKey) {
    final RenderBox? box = pinKey.currentContext?.findRenderObject() as RenderBox?;
    final Offset start = box?.localToGlobal(Offset.zero) ?? Offset.zero;
    tempEdges[edgeId] = TempEdge(id: edgeId, fromNodeId: fromNodeId, fromPinId: fromPinId, start: start, end: start);
    notifyListeners();
  }

  void updateEdgeDrag(String edgeId, Offset globalPosition) {
    if (tempEdges.containsKey(edgeId)) {
      tempEdges[edgeId] = TempEdge(
        id: tempEdges[edgeId]!.id,
        fromNodeId: tempEdges[edgeId]!.fromNodeId,
        fromPinId: tempEdges[edgeId]!.fromPinId,
        start: tempEdges[edgeId]!.start,
        end: globalPosition,
      );
      notifyListeners();
    }
  }

  void finalizeEdgeDrag(String edgeId, String fromNodeId) {
    tempEdges.remove(edgeId);
    notifyListeners();
  }

  void cancelEdgeDrag(String edgeId) {
    tempEdges.remove(edgeId);
    notifyListeners();
  }

  void addEdgeFromDrag(String edgeId, String toNodeId, String toPinId, GlobalKey pinKey) {
    final temp = tempEdges[edgeId];
    if (temp != null) {
      addEdge(FlowEdge(
        id: edgeId,
        sourceNodeId: temp.fromNodeId,
        sourcePinId: temp.fromPinId,
        targetNodeId: toNodeId,
        targetPinId: toPinId,
      ));
      tempEdges.remove(edgeId);
      notifyListeners();
    }
  }
} 