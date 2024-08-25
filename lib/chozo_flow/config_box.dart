import 'package:chozo_ui_package/chozo_flow/connections.dart';
import 'package:flutter/material.dart';

import '../components/inputs/input_box.dart';

class ConfigBox extends StatefulWidget {
  final Box details;
  const ConfigBox({super.key, required this.details});

  @override
  State<ConfigBox> createState() => _ConfigBoxState();
}

class _ConfigBoxState extends State<ConfigBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(widget.details.id),
      constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height,
          minWidth: 100,
          maxWidth: MediaQuery.sizeOf(context).width / 2),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(7)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Inputs",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...widget.details.data.map((e) => InputBox(
                    boxId: widget.details.id,
                    data: e,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
