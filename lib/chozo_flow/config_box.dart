import 'dart:math';

import 'package:chozo_ui_package/chozo_flow/connections.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v1.dart';

import '../components/inputs/input_box.dart';

class ConfigBox extends StatefulWidget {
  final Box box;
  const ConfigBox({super.key, required this.box});

  @override
  State<ConfigBox> createState() => _ConfigBoxState();
}

class _ConfigBoxState extends State<ConfigBox> {
  final Connections _connections = Connections.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(widget.box.details.id),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height,
        maxWidth: min(300, MediaQuery.sizeOf(context).width * .75),
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
              Text(
                widget.box.details.id,
                style: TextStyle(fontSize: 5),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: widget.box.details.name,
                          decoration: const InputDecoration(
                              isDense: true, border: InputBorder.none),
                          onChanged: (value) {
                            _connections.boxList[widget.box.details.id]!.details
                                .name = value;
                          },
                        ),
                        Text(
                          "id: ${widget.box.details.id}",
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
              if (widget.box.userVar != null)
                UserDefindInps(boxId: widget.box.details.id),
              const SizedBox(height: 10),
              ...widget.box.data.map((e) => InputBox(
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
              ...widget.box.inPins.map((e) => Column(
                    children: [
                      ..._connections.linkList.values
                          .where((l) => l.toPin == e)
                          .map((e) => Text(e.fromBox))
                    ],
                  )),
              const SizedBox(height: 10),
              const Text(
                "To",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              ),
              ...widget.box.outPins.map((e) => Column(
                    children: [
                      ..._connections.linkList.values
                          .where((l) => l.fromPin == e)
                          .map((e) => Text(e.toBox!))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDefindInps extends StatefulWidget {
  final String boxId;
  const UserDefindInps({super.key, required this.boxId});

  @override
  State<UserDefindInps> createState() => _UserDefindInpsState();
}

class _UserDefindInpsState extends State<UserDefindInps> {
  final Connections _connections = Connections.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_connections.boxList[widget.boxId]?.userVar != null)
          ...?_connections.boxList[widget.boxId]!.userVar
              ?.map((e) => UserVarBox(data: e, boxId: widget.boxId,)),
        InkWell(
            onTap: () {
              final i=_connections.boxList[widget.boxId]!.userVar?.length;
              _connections.boxList[widget.boxId]!.userVar
                  ?.add(UserVarData(name: "var${i??1}", type: DataType.text, id: const Uuid().v1()));
                  _connections.refresh();
            },
            child: Container(
              child: Row(
                children: [Icon(Icons.add), Text("add")],
              ),
            ))
      ],
    );
  }
}
