# intractive_flow

A customizable, user-friendly interactive flow chart package for Flutter.

## Features
- Drag-and-drop nodes
- Connect nodes with edges
- Customizable node and edge appearance
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

## Example
See the `example/` directory for a complete usage example.
