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
    // Add nodes
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
    // Example: Add a custom node widget
    controller.addNode(FlowNode(
      id: 'custom1',
      position: const Offset(200, 400),
      label: 'Custom',
      color: Colors.purple,
     
      data: {
        'customBuilder': (BuildContext context, FlowNode node) => ExampleCustomNode(node: node),
      },
    ));
    controller.addEdge(FlowEdge(
      id: 'edge1',
      sourceNodeId: 'node1',
      sourcePinId: 'a',
      targetNodeId: 'node2',
      targetPinId: 'a',
    ));
    controller.addEdge(FlowEdge(
      id: 'edge2',
      sourceNodeId: 'node2',
      sourcePinId: 'b',
      targetNodeId: 'node3',
      targetPinId: 'a',
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

// Example custom node widget
class ExampleCustomNode extends StatelessWidget {
  final FlowNode node;
  const ExampleCustomNode({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple, width: 2),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, color: Colors.purple, size: 28),
          const SizedBox(width: 8),
          Text('Custom Node!', style: TextStyle(color: Colors.purple.shade900, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
} 