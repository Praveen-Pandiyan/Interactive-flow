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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      gapPadding: 1,
                      borderSide: BorderSide(color: Colors.black45)),
                  fillColor: Colors.amberAccent,
                  isDense: true,
                  filled: true),
              onChanged: (s) {
                widget.data.change(s);
              },
            ),
          ),
        )
      ],
    );
  }
}
