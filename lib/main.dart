import 'dart:core';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'getframe.dart';

const h = 64.0;
const w = 27.0;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Oracle Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
      ),
      home: const OracleDemo(),
    );
  }
}

class OracleDemo extends StatefulWidget {
  const OracleDemo({super.key});

  @override
  State<OracleDemo> createState() => _OracleDemoState();
}

class _OracleDemoState extends State<OracleDemo> {
  int currentPageIndex = 0;
  String url = 'http://192.168.1.3/api/frames';

  Uint8List r8 = Uint8List.fromList([]);
  Uint8List ulist8 = Uint8List(1728);
  List<int> frame = [];
  bool imgCheck = false;
  List<List<int>> img = [];

  void getFrame() async {
    var response = await http.get(Uri.parse(url));
    String raw = response.body.substring(1, response.body.length - 1);
    String parse1 = raw.substring(1, raw.length - 1);
    String parse2 = parse1.replaceAll('[ [ ', '[');
    String parse3 = parse2.replaceAll(' ] ]', ']');
    Frame r = frameFromJson(parse3);

    setState(() {
      frame = r.readings.map((e) => (e * 255 / 100).round()).toList();
      r8 = Uint8List.fromList(frame);

      // ignore: unnecessary_null_comparison
      if (r8 == null) {
        imgCheck = false;
      } else {
        imgCheck = true;
      }

      for (var i = 0; i < r8.length; i += w.round()) {
        img.add(frame.sublist(
            i, i + w.round() > r8.length ? r8.length : i + w.round()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getFrame();
  }

  @override
  Widget build(BuildContext context) {
    if (currentPageIndex == 0) {
//      getFrame();
    }
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int page) {
          setState(() {
            currentPageIndex = page;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.single_bed),
            label: 'Live',
          ),
          NavigationDestination(
            icon: Icon(Icons.linear_scale),
            label: 'Settings',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
      body: <Widget>[
        Container(
            alignment: Alignment.center,
            child: CustomPaint(
              painter: SensorPainter(img),
            )
            //const Text('temp'),
/*
          child: imgCheck ? Image.memory(data) : const Text('loading...'),
*/
            ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}

class SensorPainter extends CustomPainter {
  List<List<int>> sensorData = [];
  SensorPainter(this.sensorData);

  @override
  void paint(Canvas canvas, Size size) {
    for (double y = 0; y < h; y++) {
      for (double x = 0; x < w; x++) {
        var paint = Paint()
          ..color = Colors.red.withRed(sensorData[x.round()][y.round()])
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.square;

        Rect sensor = Offset(x, y) & const Size(1, 1);

        canvas.drawRect(sensor, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
