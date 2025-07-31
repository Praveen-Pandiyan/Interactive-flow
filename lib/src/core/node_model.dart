import 'package:flutter/material.dart';

/// Model representing a pin in a flow node.
class FlowPin {
  final String id;
  final String nodeId;
  final bool isInput;
  final Offset relativePosition; // Position relative to node center
  final Color color;
  final Map<String, dynamic> data;

  FlowPin({
    required this.id,
    required this.nodeId,
    required this.isInput,
    required this.relativePosition,
    this.color = Colors.blue,
    this.data = const {},
  });

  /// Get the absolute position of the pin based on node position
  Offset getAbsolutePosition(Offset nodePosition) {
    return nodePosition + relativePosition;
  }
}

/// Model representing a node in the flow chart.
class FlowNode {
  final String id;
  Offset position;
  String label;
  Color color;
  Map<String, dynamic> data;
  final List<FlowPin> pins;

  FlowNode({
    required this.id,
    required this.position,
    required this.label,
    required this.color,
    this.data = const {},
    List<FlowPin>? pins,
  }) : pins = pins ?? _createDefaultPins(id);

  /// Create default input and output pins for a node
  static List<FlowPin> _createDefaultPins(String nodeId) {
    return [
      FlowPin(
        id: 'in',
        nodeId: nodeId,
        isInput: true,
        relativePosition: const Offset(-8, 24), // Left side, vertically centered
        color: Colors.yellowAccent,
      ),
      FlowPin(
        id: 'out',
        nodeId: nodeId,
        isInput: false,
        relativePosition: const Offset(158, 24), // Right side, vertically centered
        color: Colors.purple,
      ),
    ];
  }

  /// Get a pin by its ID
  FlowPin? getPin(String pinId) {
    try {
      return pins.firstWhere((pin) => pin.id == pinId);
    } catch (e) {
      return null;
    }
  }

  /// Get all input pins
  List<FlowPin> get inputPins => pins.where((pin) => pin.isInput).toList();

  /// Get all output pins
  List<FlowPin> get outputPins => pins.where((pin) => !pin.isInput).toList();
} 