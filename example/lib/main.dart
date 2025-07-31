import 'package:flutter/material.dart';
import 'package:intractive_flow/intractive_flow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intractive Flow Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FlowChartExample(),
    );
  }
}

class FlowChartExample extends StatefulWidget {
  const FlowChartExample({super.key});

  @override
  State<FlowChartExample> createState() => _FlowChartExampleState();
}

class _FlowChartExampleState extends State<FlowChartExample> {
  late final FlowController controller;

  @override
  void initState() {
    super.initState();
    controller = FlowController();
    
    // Create custom pins for a multi-pin node
    final customPins = [
      FlowPin(
        id: 'input1',
        nodeId: 'custom1',
        isInput: true,
        relativePosition: const Offset(-8, 20),
        color: Colors.green,
      ),
      FlowPin(
        id: 'input2',
        nodeId: 'custom1',
        isInput: true,
        relativePosition: const Offset(-8, 40),
        color: Colors.blue,
      ),
      FlowPin(
        id: 'output1',
        nodeId: 'custom1',
        isInput: false,
        relativePosition: const Offset(158, 20),
        color: Colors.red,
      ),
      FlowPin(
        id: 'output2',
        nodeId: 'custom1',
        isInput: false,
        relativePosition: const Offset(158, 40),
        color: Colors.orange,
      ),
    ];

    // Add nodes with different pin configurations
    controller.addNode(FlowNode(
      id: 'node1',
      position: const Offset(100, 100),
      label: 'Start',
      color: Colors.green,
    ));
    
    controller.addNode(FlowNode(
      id: 'node2',
      position: const Offset(300, 200),
      label: 'Middle',
      color: Colors.blue,
    ));
    
    controller.addNode(FlowNode(
      id: 'node3',
      position: const Offset(500, 300),
      label: 'End',
      color: Colors.orange,
    ));
    
    // Add a custom node with multiple pins
    controller.addNode(FlowNode(
      id: 'custom1',
      position: const Offset(200, 400),
      label: 'Multi-Pin',
      color: Colors.purple,
      pins: customPins,
    ));

    // Add edges connecting to specific pins
    controller.addEdge(FlowEdge(
      id: 'edge1',
      sourceNodeId: 'node1',
      sourcePinId: 'out',
      targetNodeId: 'node2',
      targetPinId: 'in',
    ));
    
    controller.addEdge(FlowEdge(
      id: 'edge2',
      sourceNodeId: 'node2',
      sourcePinId: 'out',
      targetNodeId: 'node3',
      targetPinId: 'in',
    ));
    
    // Connect to custom multi-pin node
    controller.addEdge(FlowEdge(
      id: 'edge3',
      sourceNodeId: 'node1',
      sourcePinId: 'out',
      targetNodeId: 'custom1',
      targetPinId: 'input1',
    ));
    
    controller.addEdge(FlowEdge(
      id: 'edge4',
      sourceNodeId: 'custom1',
      sourcePinId: 'output1',
      targetNodeId: 'node3',
      targetPinId: 'in',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Intractive Flow Example')),
      body: Center(
        child: SizedBox(
          width: 900,
          height: 600,
          child: FlowChart(controller: controller),
        ),
      ),
    );
  }
} 