import 'dart:core';

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

  List<List<int>> sensors = [];

  void getFrame() async {
    var response = await http.get(Uri.parse(url));
    String raw = response.body.substring(1, response.body.length - 1);
    String parse1 = raw.substring(1, raw.length - 1);
    String parse2 = parse1.replaceAll('[ [ ', '[');
    String parse3 = parse2.replaceAll(' ] ]', ']');
    Frame r = frameFromJson(parse3);

    setState(() {
      List<int> frame = r.readings.map((e) => (e * 255 / 100).round()).toList();

      for (var i = 0; i < frame.length; i += w.round()) {
        sensors.add(frame.sublist(
            i, i + w.round() > frame.length ? frame.length : i + w.round()));
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
        CustomPaint(
          painter: SensorPainter(sensors),
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
          ..color = Colors.red.withRed(sensorData[y.round()][x.round()])
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.square;

        Rect sensor = Offset(10 * x, 10 * y) & const Size(10, 10);

        canvas.drawRect(sensor, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
