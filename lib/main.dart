import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'getframe.dart';
import 'paintsensor.dart';

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

  List<int> frame = [];
  List<int> frame8 = [];

  void getFrame() async {
    var response = await http.get(Uri.parse(url));
    String raw = response.body.substring(1, response.body.length - 1);
    String parse1 = raw.substring(1, raw.length - 1);
    String parse2 = parse1.replaceAll('[ [ ', '[');
    String parse3 = parse2.replaceAll(' ] ]', ']');
    Frame r = frameFromJson(parse3);

    setState(() {
      frame = r.readings.toList();
      frame8 = r.readings.map((e) => (e * 255 / 100).round()).toList();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getFrame();
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
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
            painter: SensorPainter(
              frame8,
            ),
          ),
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
