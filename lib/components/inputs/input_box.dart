import 'package:chozo_ui_package/chozo_flow/connections.dart';
import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  final String boxId;
  final InputData data;
  const InputBox({super.key, required this.boxId, required this.data});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.data.name),
        const SizedBox(
          width: 3,
        ),
        TextField(
          onChanged: (s) {
            widget.data.change(s);
          },
        )
      ],
    );
  }
}
