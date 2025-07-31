import 'package:flutter_test/flutter_test.dart';
import 'package:intractive_flow/intractive_flow.dart';

void main() {
  test('FlowController can add nodes', () {
    final controller = FlowController();
    controller.addNode(FlowNode(
      id: 'test',
      position: const Offset(0, 0),
      label: 'Test',
      color: const Color(0xFFFFFFFF),
    ));
    expect(controller.nodes.containsKey('test'), isTrue);
  });
}
