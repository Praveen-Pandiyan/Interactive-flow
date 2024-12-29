import 'dart:math';

import 'package:chozo_ui_package/chozo_flow/connections.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddFunction extends StatefulWidget {
  const AddFunction({
    super.key,
  });

  @override
  State<AddFunction> createState() => _AddFunctionState();
}

class _AddFunctionState extends State<AddFunction> {
  final Connections _connections = Connections.instance;
  final String boxId = const Uuid().v4();
  late List<Box> funList;

  _onSelect(Box box) {
    _connections.isAddBlockOpen = false;
    _connections.addNewBox(box);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    funList = [
      Box(
          inPins: ["val"],
          outPins: ["out"],
          inLinks: [],
          outLinks: [],
          data: [InputData(name: "Eval", type: DataType.eval)],
          details: BoxDetails(
              id: boxId,
              refId: "eval",
              name: "Evaluation",
              pos: Offset.zero,
              type: BoxType.basic)),
      Box(
          inPins: ["val"],
          outPins: ["out"],
          inLinks: [],
          outLinks: [],
          data: [InputData(name: "Ema", type: DataType.number)],
          details: BoxDetails(
              id: boxId,
              refId: "Ema",
              name: "Ema",
              pos: Offset.zero,
              type: BoxType.basic)),
      Box(
          inPins: ["val"],
          outPins: ["true", "false"],
          inLinks: [],
          outLinks: [],
          userVar: [],
          data: [InputData(name: "Eval", type: DataType.eval)],
          details: BoxDetails(
              id: boxId,
              refId: "if",
              name: "If",
              pos: Offset.zero,
              type: BoxType.basic))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('add_function_34324'),
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
                      ...funList.map((e) => InkWell(
                            onTap: () {
                              _onSelect(e);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.details.name,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    e.details.type.name,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
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
