import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intractive_flow/intractive_flow.dart';

void main() {
  group('FlowPin Tests', () {
    test('should create a pin with correct properties', () {
      final pin = FlowPin(
        id: 'test_pin',
        nodeId: 'test_node',
        isInput: true,
        relativePosition: const Offset(10, 20),
        color: Colors.red,
      );

      expect(pin.id, 'test_pin');
      expect(pin.nodeId, 'test_node');
      expect(pin.isInput, true);
      expect(pin.relativePosition, const Offset(10, 20));
      expect(pin.color, Colors.red);
    });

    test('should calculate absolute position correctly', () {
      final pin = FlowPin(
        id: 'test_pin',
        nodeId: 'test_node',
        isInput: true,
        relativePosition: const Offset(10, 20),
      );

      final nodePosition = const Offset(100, 200);
      final absolutePosition = pin.getAbsolutePosition(nodePosition);

      expect(absolutePosition, const Offset(110, 220));
    });
  });

  group('FlowNode Tests', () {
    test('should create a node with default pins', () {
      final node = FlowNode(
        id: 'test_node',
        position: const Offset(100, 100),
        label: 'Test Node',
        color: Colors.blue,
      );

      expect(node.id, 'test_node');
      expect(node.pins.length, 2);
      expect(node.inputPins.length, 1);
      expect(node.outputPins.length, 1);
    });

    test('should create a node with custom pins', () {
      final customPins = [
        FlowPin(
          id: 'input1',
          nodeId: 'test_node',
          isInput: true,
          relativePosition: const Offset(-8, 20),
        ),
        FlowPin(
          id: 'output1',
          nodeId: 'test_node',
          isInput: false,
          relativePosition: const Offset(158, 20),
        ),
      ];

      final node = FlowNode(
        id: 'test_node',
        position: const Offset(100, 100),
        label: 'Test Node',
        color: Colors.blue,
        pins: customPins,
      );

      expect(node.pins.length, 2);
      expect(node.getPin('input1'), isNotNull);
      expect(node.getPin('output1'), isNotNull);
      expect(node.getPin('nonexistent'), isNull);
    });
  });

  group('FlowController Tests', () {
    test('should get pin position correctly', () {
      final controller = FlowController();
      
      final node = FlowNode(
        id: 'test_node',
        position: const Offset(100, 100),
        label: 'Test Node',
        color: Colors.blue,
      );

      controller.addNode(node);

      final pinPosition = controller.getPinPosition('test_node', 'in');
      expect(pinPosition, isNotNull);
      expect(pinPosition!.dx, 92); // 100 - 8
      expect(pinPosition.dy, 124); // 100 + 24
    });

    test('should get edge positions correctly', () {
      final controller = FlowController();
      
      final node1 = FlowNode(
        id: 'node1',
        position: const Offset(100, 100),
        label: 'Node 1',
        color: Colors.blue,
      );

      final node2 = FlowNode(
        id: 'node2',
        position: const Offset(300, 100),
        label: 'Node 2',
        color: Colors.red,
      );

      controller.addNode(node1);
      controller.addNode(node2);

      final edge = FlowEdge(
        id: 'edge1',
        sourceNodeId: 'node1',
        sourcePinId: 'out',
        targetNodeId: 'node2',
        targetPinId: 'in',
      );

      final sourcePosition = controller.getEdgeSourcePosition(edge);
      final targetPosition = controller.getEdgeTargetPosition(edge);

      expect(sourcePosition, isNotNull);
      expect(targetPosition, isNotNull);
    });
  });
} 