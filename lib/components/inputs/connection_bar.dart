import 'package:chozo_ui_package/chozo_flow/connections.dart';
import 'package:flutter/material.dart';

class ConnectionBar extends StatefulWidget {
  final String connectionId;
  const ConnectionBar({super.key, required this.connectionId});

  @override
  State<ConnectionBar> createState() => _ConnectionBarState();
}

class _ConnectionBarState extends State<ConnectionBar> {
  final Connections _connections = Connections.instance;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("title"),
        const Text("id"),
        IconButton(
            onPressed: () {
              _connections.removeConnection(widget.connectionId);
            },
            icon: const Icon(Icons.delete))
      ],
    );
  }
}
