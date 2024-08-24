import 'package:chozo_ui_package/chozo_flow/connections.dart';
import 'package:flutter/material.dart';

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
      child: SingleChildScrollView(
        child: Column(
          children: [...widget.details.data.map((e) => Text(e.name))],
        ),
      ),
    );
  }
}
