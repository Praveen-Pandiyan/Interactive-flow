
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
  final Connections _connections = Connections.instance;
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
            child: ClipRRect(
              borderRadius:  BorderRadius.circular(6),
              child: TextFormField(
                initialValue: widget.data.value,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color.fromARGB(127, 221, 221, 221),
                    isDense: true,
                    filled: true),
                onChanged: (s) {
                  widget.data.change(s);
                  _connections.refresh();
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
