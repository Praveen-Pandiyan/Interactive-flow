import 'dart:math';

import 'package:chozo_ui_package/chozo_flow/connections.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../components/inputs/input_box.dart';

class VarPannel extends StatefulWidget {
  const VarPannel({
    super.key,
  });

  @override
  State<VarPannel> createState() => _VarPannelState();
}

class _VarPannelState extends State<VarPannel> {
  final Connections _connections = Connections.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('var_pannel_34324'),
      constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height,
          maxWidth: min(300, MediaQuery.sizeOf(context).width * .75),
          minWidth: 200),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(7)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Storage"),
                          IconButton(
                              onPressed: () {
                                _connections.openedView = OpenedView.none;
                                _connections.refresh();
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      ..._connections.varList.values.map((e) => UserVarBox(
                            data: e,
                            id: e.id,
                            isBelongsToBox: false,
                          )),
                      InkWell(
                          onTap: () {
                            final id = const Uuid().v4();

                            _connections.varList.addAll({
                              id: UserVarData(
                                  name: "var${_connections.varList.length}",
                                  type: DataType.text,
                                  id: id)
                            });
                            _connections.refresh();
                          },
                          child: const Row(
                            children: [Icon(Icons.add), Text("add")],
                          ))
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
