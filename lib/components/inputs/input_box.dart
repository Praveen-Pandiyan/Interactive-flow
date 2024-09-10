
import 'package:chozo_ui_package/chozo_flow/connections.dart';
import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  final InputData data;
  const InputBox({super.key, required this.data});

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
class UserVarBox extends StatefulWidget {
  final UserVarData data;
  final String boxId;
  const UserVarBox({super.key, required this.data, required this.boxId});

  @override
  State<UserVarBox> createState() => _UserVarBoxState();
}

class _UserVarBoxState extends State<UserVarBox> {
  final Connections _connections = Connections.instance;
  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key(widget.data.id),
      children: [
       Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius:  BorderRadius.circular(6),
              child: TextFormField(
                initialValue: widget.data.name,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color.fromARGB(127, 221, 221, 221),
                    isDense: true,
                    filled: true),
                onChanged: (s) {
                  widget.data.changeName(s);
                  _connections.refresh();
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        Text(widget.data.id.split('-').first),
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
                  widget.data.changeValue(s);
                  _connections.refresh();
                },
              ),
            ),
          ),
        ),
        IconButton(onPressed: (){
          _connections.boxList[widget.boxId]!.userVar?.removeWhere((i)=>i.id==widget.data.id);
          _connections.refresh();
          print("${widget.data.id}, ${_connections.boxList[widget.boxId]!.userVar?.map((e)=>e.toJson())}");
        }, icon: Icon(Icons.delete))
      ],
    );
  }
}
