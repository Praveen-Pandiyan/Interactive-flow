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
    // Add two nodes and an edge for demonstration
    controller.addNode(FlowNode(
      id: 'node1',
      position: const Offset(100, 100),
      label: 'Start',
      color: Colors.green,
      outputPins: ['out'],
    ));
    controller.addNode(FlowNode(
      id: 'node2',
      position: const Offset(300, 200),
      label: 'End',
      color: Colors.orange,
      inputPins: ['in'],
    ));
    controller.addEdge(FlowEdge(
      id: 'edge1',
      sourceNodeId: 'node1',
      sourcePinId: 'out',
      targetNodeId: 'node2',
      targetPinId: 'in',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Intractive Flow Example')),
      body: Center(
        child: SizedBox(
          width: 600,
          height: 400,
          child: FlowChart(controller: controller),
        ),
      ),
    );
  }
} 