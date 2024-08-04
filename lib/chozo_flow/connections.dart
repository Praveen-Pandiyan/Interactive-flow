import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../utils/extensions/offset.dart';

class Connections extends ChangeNotifier {
  Connections._();
  static final instance = Connections._();
  Map<String, Link> linkList = {};
  Map<String, Box> boxList = {};

  void create(String id, fromId, Offset delta, localPos) {
    if (linkList[id] == null) {
      linkList.addAll(
          {id: Link(id: id, fromPin: fromId, start: localPos, end: localPos)});
    } else {
      positionUpdate(delta, [id], []);
    }
  }

  void positionUpdate(Offset delta, List<String> inpConId, outConId) {
    for (var e in inpConId) {
      if (linkList[e] != null) {
        linkList[e]?.end += delta;
      } else {
        // create
      }
    }
    for (var e in outConId) {
      if (linkList[e] != null) {
        linkList[e]?.start += delta;
      } else {}
    }
    notifyListeners();
  }

  void onConnection(String id, toId, Offset pos) {
    linkList[id]
      ?..end = pos
      ..toPin = toId;
    notifyListeners();
  }

  void addNewBox() {
    String _boxId = const Uuid().v1();
    boxList.addAll({
      _boxId: Box(
          id: _boxId,
          pos: Offset.zero,
          data: [
            InputData(name: "ema", type: DataType.number),
            InputData(name: "sma", type: DataType.number)
          ],
          inPins: ["srfreg", "dewf"],
          outPins: ["frwfef", "fer"],
          inLinks: [],
          outLinks: [],
          refId: "cdfc")
    });
    notifyListeners();
  }

  loadFlow(Map<String, dynamic> json) {
    final data = AlgoData.fromJson(json);
    boxList.addEntries(data.boxs.map((e) => MapEntry(e.id, e)));
    linkList.addEntries(data.links.map((e) => MapEntry(e.id, e)));
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return AlgoData(
            boxs: boxList.values.toList(),
            links: linkList.values.toList(),
            id: "dferf",
            consoleVersion: "0.0.1",
            version: "23432443",
            name: "chumma")
        .toJson();
  }
}

class AlgoData {
  final List<Link> links;
  final List<Box> boxs;
  final String id;
  final String name;
  final String consoleVersion;
  final String version;

  AlgoData(
      {required this.links,
      required this.boxs,
      required this.id,
      required this.name,
      required this.consoleVersion,
      required this.version});

  AlgoData.fromJson(Map<String, dynamic> data)
      : this(
            links:
                (data['links'] as List).map((e) => Link.fromJson(e)).toList(),
            boxs: (data['boxs'] as List).map((e) => Box.fromJson(e)).toList(),
            id: data['id'],
            name: data['name'],
            consoleVersion: data['cversion'],
            version: data['version']);
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'boxs': boxs.map((e) => e.toJson()).toList(),
      'links': links.map((e) => e.toJson()).toList(),
      'cversion': consoleVersion,
      'version': version
    };
  }
}

class Link {
  String id, fromPin;
  String? toPin;
  Offset start, end;

  Link({
    required this.id,
    required this.fromPin,
    this.toPin,
    this.start = Offset.zero,
    this.end = Offset.zero,
  });
  Link.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            fromPin: json['fpin'],
            toPin: json['tpin'],
            start: toOffset(json['s']),
            end: toOffset(json['e']));

  Map toJson() {
    return {
      'id': id,
      'fpin': fromPin,
      'tpin': toPin,
      's': start.toJson(),
      'e': end.toJson()
    };
  }

  @override
  String toString() {
    return "${start} ${end}";
  }
}

class Box {
  String id, refId;
  Offset pos;
  List<String> inPins, outPins;
  List<String> inLinks, outLinks;
  List<InputData> data;

  Box(
      {required this.id,
      required this.pos,
      required this.inPins,
      required this.outPins,
      required this.inLinks,
      required this.outLinks,
      required this.data,
      required this.refId});

  Box.fromJson(json)
      : this(
            id: json['id'],
            inPins: json['ipin'],
            outPins: json['opin'],
            inLinks: json['ilinks'] ,
            outLinks: json['olinks'],
            refId: json['refId'],
            pos: toOffset(json['pos']),
            data: (json['data'] as List)
                .map((e) => InputData.fromJson(e))
                .toList());

              
  toJson() {
    return {
      'id': id,
      'ipin': inPins,
      'opin': outPins,
      'refId': refId,
      'ilinks':inLinks,
      'olinks':outLinks,
      'pos': pos.toJson(),
      'data': data.map((e) => e.toJson()).toList()
    };
  }
}

enum DataType { number, text, color }
class InputData {
  final String name;
  final DataType type;
  dynamic value;

  InputData({required this.name, required this.type, this.value = ''});
  InputData.fromJson(data)
      : this(
            name: data['name'],
            type: switch (data['type']) {
              'number' => DataType.number,
              'color' => DataType.color,
              'text' || _ => DataType.text
            },
            value: data['value'] ?? '');

  toJson() {
    return {'name': name, 'type': type.name, 'value': value};
  }
}

class ArrowPainter extends CustomPainter {
  ///
  ArrowPainter({
    required this.from,
    required this.to,
  });

  ///
  final Offset from;

  ///
  final Offset to;

  ///
  final Path path = Path();

  ///
  final List<List<Offset>> lines = [];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 1.0;

    drawCurve(canvas, paint);

    canvas.drawCircle(to, 2, paint);

    paint
      ..color = Colors.black
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  void drawCurve(Canvas canvas, Paint paint) {
    // mutable
    double tension = 1.0;
    Alignment startArrowPosition = Alignment.centerRight;
    Alignment endArrowPosition = Alignment.centerLeft;

    var distance = 0.0;

    var dx = 0.0;
    var dy = 0.0;

    final p0 = Offset(from.dx, from.dy);
    final p4 = Offset(to.dx, to.dy);
    distance = (p4 - p0).distance / 3;

    // checks for the arrow direction
    if (startArrowPosition.x > 0) {
      dx = distance;
    } else if (startArrowPosition.x < 0) {
      dx = -distance;
    }
    if (startArrowPosition.y > 0) {
      dy = distance;
    } else if (startArrowPosition.y < 0) {
      dy = -distance;
    }
    final p1 = Offset(from.dx + dx, from.dy + dy);
    dx = 0;
    dy = 0;

    // checks for the arrow direction
    if (endArrowPosition.x > 0) {
      dx = distance;
    } else if (endArrowPosition.x < 0) {
      dx = -distance;
    }
    if (endArrowPosition.y > 0) {
      dy = distance;
    } else if (endArrowPosition.y < 0) {
      dy = -distance;
    }
    final p3 = endArrowPosition == Alignment.center
        ? Offset(to.dx, to.dy)
        : Offset(to.dx + dx, to.dy + dy);
    final p2 = Offset(
      p1.dx + (p3.dx - p1.dx) / 2,
      p1.dy + (p3.dy - p1.dy) / 2,
    );

    path
      ..moveTo(p0.dx, p0.dy)
      ..conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1)
      ..conicTo(p3.dx, p3.dy, p4.dx, p4.dy, 1);
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) {
    return true;
  }

  @override
  bool? hitTest(Offset position) => false;
}
