import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
      ),
      home: const FacilityView(),
    );
  }
}

//FACILITY VIEW

class FacilityView extends StatefulWidget {
  const FacilityView({super.key});

  @override
  State<FacilityView> createState() => _FacilityViewState();
}

class _FacilityViewState extends State<FacilityView> {
  final facilityName = 'Jackson Medical Solutions';
  List<Patient> patient = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('$facilityName Overview')),
      ),
      body: null,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const PatientForm();
              },
            ),
          );
        },
      ),
    );
  }
}

//FACILITY VIEW
//PATIENT FORM PAGE

class PatientForm extends StatefulWidget {
  const PatientForm({super.key});

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final _patientFormKey = GlobalKey<FormState>();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final bdayController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final sexController = TextEditingController();

  final apiurl = 'https://test.api.jacksonmed.org/patient';

  Patient patient = Patient(
    fname: '',
    lname: '',
    bday: '',
    height: '',
    weight: '',
    sex: '',
  );

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

  Future<http.Response> createPatient(Patient p) {
    return http.post(
      Uri.parse(apiurl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "firstName": p.fname,
        "lastName": p.lname,
        "birthday": p.bday,
        "height": p.height,
        "weight": p.weight,
        "sex": p.sex
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('New Patient')),
      ),
      body: Form(
        key: _patientFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: fnameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                hintText: 'ex: Anakin',
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
                labelText: 'Last Name',
                hintText: 'ex: Skywalker',
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
                icon: Icon(Icons.calendar_today),
                labelText: 'Date of Birth',
              ),
              readOnly: true,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
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
                if (_patientFormKey.currentState!.validate()) {
                  patient.fname = fnameController.text;
                  patient.lname = lnameController.text;
                  patient.bday = bdayController.text;
                  patient.height = heightController.text;
                  patient.weight = weightController.text;
                  patient.sex = sexController.text;
                  createPatient(patient);
                }
              },
              child: const Text('Save & Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

//PATIENT FORM
//ORACLE DEMO

class OracleDemo extends StatefulWidget {
  const OracleDemo({super.key});

  @override
  State<OracleDemo> createState() => _OracleDemoState();
}

class _OracleDemoState extends State<OracleDemo> {
  int currentPageIndex = 0;
  String url = 'http://192.168.1.3/api/frames';

  List<int> frame = List<int>.filled(1728, 0);

  @override
  void initState() {
    super.initState();
  }

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
