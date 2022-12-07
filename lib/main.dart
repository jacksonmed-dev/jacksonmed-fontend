import 'dart:core';
import 'dart:developer';
import 'dart:ui';

import 'ducky.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'getframe.dart';

const h = 64;
const w = 27;

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
  List<int> frame = [];
  //Uint8List img = Uint8List.fromList([]);
  var img;
  bool nulltest = false;

  void dummyCallbackFunction(image) {
    print('image received');
  }

  void getFrame() async {
    var response = await http.get(Uri.parse(url));
    String raw = response.body.substring(1, response.body.length - 1);
    String parse1 = raw.substring(1, raw.length - 1);
    String parse2 = parse1.replaceAll('[ [ ', '[');
    String parse3 = parse2.replaceAll(' ] ]', ']');
    Frame r = frameFromJson(parse3);
    Uint8List data =
        (await rootBundle.load('assets/images.png')).buffer.asUint8List();

    // copy from decodeImageFromList of package:flutter/painting.dart
    //Convert parsing method to for loop?
    //-> after that, just learn to parse the data directly from the map
    setState(() {
//      frame = r.readings.map((e) => e * 2).toList();
      frame = r.readings.toList();
      //Probably need to loop through and manually adjust
      //each variable in frame (ex: 0 -> 0, 100 -> 256).
      r8 = Uint8List.fromList(frame);
      decodeImageFromPixels(
          ducky, w, h, PixelFormat.bgra8888, dummyCallbackFunction);
      img = data;

      if (img == null) {
        nulltest = false;
      } else {
        nulltest = true;
      }

/*
      for (var i = 0; i < r8.length; i += w) {
        img.add(r8.sublist(i, i + w > r8.length ? r8.length : i + w));
      }
      */
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
          child: nulltest ? Image.memory(r8) : const Text('loading...'),
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
