import 'package:flutter/material.dart';

extension OffsetEncode on Offset {


  Map<String, dynamic> toJson() {
    return {'x': dx, 'y': dy};
  }
}

Offset toOffset(json) {
    return Offset(json['x'], json['y']);
  }