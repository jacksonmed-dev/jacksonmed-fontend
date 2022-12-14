import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:intl/intl.dart';

import 'getframe.dart';
import 'paintsensor.dart';
import 'patients.dart';

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
  String apiurl = 'https://test.api.jacksonmed.org/patient';

//  List<Patient> patient = [];
  List<int> frame = List<int>.filled(1728, 0);

  Patient patient = Patient(
    fname: '',
    lname: '',
    bday: '',
    height: '',
    weight: '',
    sex: '',
  );

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final bdayController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final sexController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    bdayController.dispose();
    heightController.dispose();
    weightController.dispose();
    sexController.dispose();
    super.dispose();
  }

  void getFrame() async {
    var response = await http.get(Uri.parse(url));
    Frame r = frameFromJson(response.body);

    setState(() {
      frame = r.readings.toList();
    });
  }

  Future<http.Response> createPatient(Patient pat) {
    return http.post(
      Uri.parse(apiurl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "firstName": pat.fname,
        "lastName": pat.lname,
        "birthday": pat.bday,
        "height": pat.height,
        "weight": pat.weight,
        "sex": pat.sex
      }),
    );
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
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: fnameController,
                decoration: const InputDecoration(
                  hintText: 'First Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lnameController,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: bdayController,
                decoration: const InputDecoration(
//                  labelText: 'Date of Birth',
//                  hintText: 'Birthdate',
                    ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: heightController,
                decoration: const InputDecoration(
                  hintText: 'Height',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(
                  hintText: 'Weight',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: sexController,
                decoration: const InputDecoration(
                  hintText: 'Sex',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    patient.fname = fnameController.text;
                    patient.lname = lnameController.text;
                    patient.bday = bdayController.text;
                    patient.height = heightController.text;
                    patient.weight = weightController.text;
                    patient.sex = sexController.text;
                    createPatient(patient);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}
