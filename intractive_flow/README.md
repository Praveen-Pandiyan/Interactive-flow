# intractive_flow

A customizable, user-friendly interactive flow chart package for Flutter with pin-based connections.

## Features
- Drag-and-drop nodes
- Connect nodes with edges through individual pins
- Support for multiple input and output pins per node
- Customizable pin positions and colors
- Reactive and modular design

## Usage

Add to your `pubspec.yaml`:
```yaml
dependencies:
  intractive_flow:
    path: ../intractive_flow
```

Import and use in your Flutter app:
```dart
import 'package:intractive_flow/intractive_flow.dart';

final controller = FlowController();

@override
Widget build(BuildContext context) {
  return FlowChart(controller: controller);
}
```

## Pin-Based Connections

The package now supports connecting edges to individual pins rather than entire nodes. Each node can have multiple input and output pins with custom positions and colors.

### Creating Nodes with Default Pins

```dart
// Create a node with default input and output pins
final node = FlowNode(
  id: 'node1',
  position: const Offset(100, 100),
  label: 'My Node',
  color: Colors.blue,
);
```

### Creating Nodes with Custom Pins

```dart
// Create custom pins
final customPins = [
  FlowPin(
    id: 'input1',
    nodeId: 'node1',
    isInput: true,
    relativePosition: const Offset(-8, 20),
    color: Colors.green,
  ),
  FlowPin(
    id: 'output1',
    nodeId: 'node1',
    isInput: false,
    relativePosition: const Offset(158, 20),
    color: Colors.red,
  ),
];

// Create a node with custom pins
final node = FlowNode(
  id: 'node1',
  position: const Offset(100, 100),
  label: 'Custom Node',
  color: Colors.purple,
  pins: customPins,
);
```

### Connecting Pins with Edges

```dart
// Connect specific pins between nodes
final edge = FlowEdge(
  id: 'edge1',
  sourceNodeId: 'node1',
  sourcePinId: 'output1',  // Connect from specific output pin
  targetNodeId: 'node2',
  targetPinId: 'input1',   // Connect to specific input pin
);

controller.addEdge(edge);
```

## Example
See the `example/` directory for a complete usage example with multi-pin nodes and custom connections.
