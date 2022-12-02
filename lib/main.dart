import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as im;

import 'getframe.dart';

const h = 64;
const w = 27;
const f = PixelFormat.rgba8888;

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
  String url = 'http://192.168.1.34/api/frames';
  String jsonFrame = 'assets/testdata.txt';
//  List<int> frame = [];
  var r8;
//  Image pic;

  //need to declare this as Uint8List

  void getFrame() async {
//    var response = await http.get(Uri.parse(url));
//    String raw = response.body.substring(1, response.body.length - 1);
    String response = await rootBundle.loadString(jsonFrame);
    String raw = response.substring(1, response.length - 1);
    String parse1 = raw.substring(1, raw.length - 1);
    String parse2 = parse1.replaceAll('[ [ ', '[');
    String parse3 = parse2.replaceAll(' ] ]', ']');
    Frame r = frameFromJson(parse3);
    final img = im.Image(w, h);

    //Convert parsing method to for loop?
    setState(() {
      List<int> frame = r.readings.map((e) => e * 2).toList();
      //Probably need to loop through and manually adjust
      //each variable in frame (ex: 0 -> 0, 100 -> 256).
      Uint8List r8 = Uint8List.fromList(frame);
      for (var i = 0, len = h; i < len; i++) {
        for (var j = 0, len = w; j < len; j++) {
          img.setPixel(i, j, r8[i + j]);
        }
      }
//      Uint8List pngBytes = Uint8List.fromList(im.encodePng(img));
//      final image = Image.memory(pngBytes);
//      pic = image;
    });
  }

  @override
  void initState() {
    getFrame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
//            if (index == 0) {
//              getFrame();
//            }
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
          child: Text('$r8'),
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
