import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'facility_view.dart';

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
      ),
      home: const FacilityView(),
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

  List<int> frame = List<int>.filled(1728, 0);

  void getFrame() async {
    var response = await http.get(Uri.parse(url));
    Frame r = frameFromJson(response.body);

    setState(() {
      frame = r.readings.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentPageIndex == 0) {
      getFrame();
    }
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
        Transform.scale(
          scale: 10,
          child: Center(
            child: CustomPaint(
              painter: SensorPainter(frame),
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
