import 'dart:math';

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
  final Connections _connections = Connections.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(widget.details.id),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height,
        maxWidth: min(300, MediaQuery.sizeOf(context).width *.75),
      ),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(7)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: widget.details.details.name,
                          decoration: const InputDecoration(
                              isDense: true, border: InputBorder.none),
                          onChanged: (value) {
                            _connections.boxList[widget.details.id]!.details
                                .name = value;
                          },
                        ),
                        Text(
                          "id: ${widget.details.id}",
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _connections.selectedId = null;
                      _connections.refresh();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Inputs",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
              ),
               const SizedBox(height: 10),
              ...widget.details.data.map((e) => InputBox(
                    boxId: widget.details.id,
                    data: e,
                  )),
              const SizedBox(height: 20),
              const Text(
                "Connections",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                "From",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              ),
              ...widget.details.inLinks.map((e)=>Text(e)),
              const SizedBox(height: 10),
              const Text(
                "To",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              ),
              ...widget.details.outLinks.map((e)=>Text(e))
            ],
          ),
        ),
      ),
    );
  }
}
