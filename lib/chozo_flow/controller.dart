import 'dart:convert';

import 'package:chozo_ui_package/chozo_flow/connections.dart';

class ChozoFlowController {
  final Connections connections = Connections.instance;

  void loadJson(Map<String, dynamic> json) {
    connections.loadFlow(json);
  }

  String getJson() {
    return json.encode(connections.toJson());
  }

  bool validateJson(Map<String, dynamic> json) {
    // Add your validation logic here
    // For example, check if required keys are present
    if (json.containsKey('id') &&
        json.containsKey('name') &&
        json.containsKey('boxs')) {
      return true;
    }
    return false;
  }
}
