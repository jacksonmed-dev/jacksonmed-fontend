import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'getframe.dart';
import 'paintsensor.dart';

class PatientView extends StatefulWidget {
  const PatientView({super.key});

  @override
  State<PatientView> createState() => _PatientViewState();
}

class _PatientViewState extends State<PatientView> {
  String url = 'http://192.168.1.4/api/frames';
  List<int> frame = List<int>.filled(1728, 0);

  void getFrame() async {
    var response = await http.get(Uri.parse(url));
    Frame r = frameFromJson(response.body);

    setState(() {
      frame = r.readings.toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getFrame();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('*Insert Patient Name*')),
      ),
      body: Transform.scale(
        scale: 10,
        child: Center(
          child: CustomPaint(
            painter: SensorPainter(frame),
          ),
        ),
      ),
    );
  }
}
 

//I imagine the widget looking like this:
//LEFT: Collapsable side bar Photo, Name (Big), Age & Birthday, Weight & Gender,
//Fall Risk & Bedsore Risk
//CENTER: Sensor Live View with Risk, Attended Information, Live Vitals
//BOTTOM CENTER: Sleep Information
//BOTTOM RIGHT: Button to view History