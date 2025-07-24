import 'package:flutter/material.dart';

/// Model representing a node in the flow chart.
class FlowNode {
  final String id;
  Offset position;
  String label;
  Color color;
  Map<String, dynamic> data;

  FlowNode({
    required this.id,
    required this.position,
    required this.label,
    required this.color,
    this.data = const {},
  });
} 