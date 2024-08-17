import 'package:flutter/material.dart';

import '../../utils/validate_eval.dart';

class EvalBox extends StatefulWidget {
  final Function(String) onChange, onError;
  const EvalBox({super.key, required this.onChange, required this.onError});

  @override
  State<EvalBox> createState() => _EvalBoxState();
}

class _EvalBoxState extends State<EvalBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        widget.onChange(value);
        isEvalValid(value);
      },
    );
  }
}
