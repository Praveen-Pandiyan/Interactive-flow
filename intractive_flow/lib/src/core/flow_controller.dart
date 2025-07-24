import 'package:flutter/material.dart';
import 'node_model.dart';
import 'edge_model.dart';

/// Controller for managing the state and logic of the interactive flow chart.
class FlowController extends ChangeNotifier {
  final Map<String, FlowNode> nodes = {};
  final Map<String, FlowEdge> edges = {};

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
} 