import 'package:flutter/material.dart';
import '../utils/extensions/offset.dart';

// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as math;

class Connections extends ChangeNotifier {
  Connections._();
  static final instance = Connections._();
  late TransformationController viewerPosition;
  late GlobalKey key;
  Map<String, Link> linkList = {};
  Map<String, Box> boxList = {};
  String? selectedId, secondarySelectedId;
  bool isAddBlockOpen = false;
  void refresh() {
    notifyListeners();
  }

  void create(String id, fromPin, fromBox, Offset delta, localPos) {
    if (linkList[id] == null) {
      linkList.addAll({
        id: Link(
            id: id,
            fromPin: fromPin,
            fromBox: fromBox,
            start: localPos,
            end: localPos)
      });
    } else {
      positionUpdate(null, null, delta, [id], []);
    }
  }

  void positionUpdate(String? boxId, Offset? pos, Offset delta,
      List<String> inpConId, outConId) {
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

    if (boxId != null) {
      boxList[boxId]?.details.pos = pos!;
    }
    notifyListeners();
  }

  void onConnection(String id, toId, boxId, Offset pos) {
// check if exist
    if (((boxList[boxId]
                ?.inLinks
                .where((e) =>
                    linkList[e]?.toPin == toId &&
                    linkList[e]?.toBox == boxId &&
                    linkList[e]?.fromPin == linkList[id]?.fromPin &&
                    linkList[e]?.fromBox == linkList[id]?.fromBox)
                .length ??
            0) >
        0)) {
      removeConnection(id); // removes pending link
    } else if (_checkLoop(linkList[id]!.fromBox, boxId) ?? false) {
      print("is loop");
      removeConnection(id); // removes pending link
    } else {
      linkList[id]
        ?..end = pos
        ..toPin = toId
        ..toBox = boxId;
    }
    notifyListeners();
  }

  _checkLoop(String searchBoxId, String indexBoxId) {
    for (var link in boxList[indexBoxId]!.outLinks) {
      if (linkList[link]?.toBox == searchBoxId) {
        return true;
      } else if (linkList[link]?.toBox != null) {
        var r = _checkLoop(searchBoxId, linkList[link]!.toBox!) ?? false;
        if (r) return true;
      }
    }
  }

  void removeConnection(String id) {
    boxList[linkList[id]!.fromBox]?.outLinks.remove(id);
    boxList[linkList[id]!.toBox]?.inLinks.remove(id);
    linkList.remove(id);
    notifyListeners();
  }

  void addNewBox(Box box) {
    boxList.addAll({box.details.id: box});
    notifyListeners();
  }

  loadFlow(Map<String, dynamic> json) {
    final data = AlgoData.fromJson(json);
    boxList.addEntries(data.boxs.map((e) => MapEntry(e.details.id, e)));
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

  getPosOfElement(elementKey) {
    final Matrix4 matrix = viewerPosition.value;
    final double scale = matrix.getMaxScaleOnAxis();
    final math.Vector3 translation = matrix.getTranslation();
    final double x = -translation.x / scale;
    final double y = -translation.y / scale;
    Offset gloablpos = -getPositionOfBox(key,
        offset: -getPositionOfBox(elementKey, offset: Offset(x, y)));
    return (gloablpos / scale);
  }
}

getPositionOfBox(GlobalKey key, {Offset offset = Offset.zero}) {
  RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
  return box.localToGlobal(offset);
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
  String id, fromPin, fromBox;
  String? toPin, toBox;
  Offset start, end;

  Link({
    required this.id,
    required this.fromPin,
    required this.fromBox,
    this.toPin,
    this.toBox,
    this.start = Offset.zero,
    this.end = Offset.zero,
  });
  Link.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            fromPin: json['fpin'],
            fromBox: json['fbox'],
            toPin: json['tpin'],
            toBox: json['tbox'],
            start: toOffset(json['s']),
            end: toOffset(json['e']));

  Map toJson() {
    return {
      'id': id,
      'fpin': fromPin,
      'fbox': fromBox,
      'tpin': toPin,
      'tbox': toBox,
      's': start.toJson(),
      'e': end.toJson()
    };
  }

  @override
  String toString() {
    return "$start $end";
  }
}

class Box {
  BoxDetails details;
  List<String> inPins, outPins;
  List<String> inLinks, outLinks;
  List<InputData> data;
  List<UserVarData>? userVar;

  Box(
      {required this.inPins,
      required this.outPins,
      required this.inLinks,
      required this.outLinks,
      required this.data,
      this.userVar,
      required this.details});

  Box.fromJson(json)
      : this(
            inPins: json['ipin'],
            outPins: json['opin'],
            inLinks: (json['ilinks'] as List).map((e) => e.toString()).toList(),
            outLinks:
                (json['olinks'] as List).map((e) => e.toString()).toList(),
            details: BoxDetails.fromJson(json['details']),
            data: (json['data'] as List)
                .map((e) => InputData.fromJson(e))
                .toList(),
            userVar: (json['userVar'] as List)
                .map((e) => UserVarData.fromJson(e))
                .toList());

  toJson() {
    return {
      'ipin': inPins,
      'opin': outPins,
      'ilinks': inLinks,
      'olinks': outLinks,
      'details': details.toJson(),
      'data': data.map((e) => e.toJson()).toList(),
      'userVar': userVar?.map((e) => e.toJson()).toList()
    };
  }
}

enum DataType { number, text, color, eval }

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
  change(v) {
    value = v;
  }

  toJson() {
    return {'name': name, 'type': type.name, 'value': value};
  }
}

class UserVarData {
  final String id;
  String name;
  DataType type;
  dynamic value;

  UserVarData(
      {required this.name,
      required this.type,
      this.value = '',
      required this.id});
  UserVarData.fromJson(data)
      : this(
            id: data['id'],
            name: data['name'],
            type: switch (data['type']) {
              'number' => DataType.number,
              'color' => DataType.color,
              'text' || _ => DataType.text
            },
            value: data['value'] ?? '');
  changeName(String v) {
    name = v;
  }

  changeType(DataType v) {
    type = v;
  }

  changeValue(v) {
    value = v;
  }

  toJson() {
    return {'id': id, 'name': name, 'type': type.name, 'value': value};
  }
}

enum BoxType { basic, external, order, start, alert, store }

class BoxDetails {
  final String id, refId;
  Offset pos;
  String name;
  Color color;
  final BoxType type;
  BoxDetails(
      {required this.id,
      required this.refId,
      required this.name,
      required this.pos,
      this.color = Colors.grey,
      required this.type});
  BoxDetails.fromJson(data)
      : this(
          name: data['name'],
          id: data['id'],
          color: Colors.red,
          refId: data['refId'],
          pos: toOffset(data['pos']),
          type: switch (data['type']) {
            'basic' => BoxType.basic,
            'external' => BoxType.external,
            'order' => BoxType.order,
            'start' => BoxType.start,
            'alert' => BoxType.alert,
            'store' => BoxType.store,
            'text' || _ => BoxType.start
          },
        );
  toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.toString(),
      'type': type.name,
      'refId': refId,
      'pos': pos.toJson(),
    };
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
