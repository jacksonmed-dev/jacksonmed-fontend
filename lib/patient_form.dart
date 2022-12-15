import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'patients.dart';

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
  void initState() {
    fnameController.text = '';
    lnameController.text = '';
    bdayController.text = '';
    heightController.text = '';
    weightController.text = '';
    sexController.text = '';
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
                DateTime? dob = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (dob != null) {
                  String formattedDate = DateFormat('MM/dd/yyyy').format(dob);
                  setState(() {
                    bdayController.text = formattedDate;
                  });
                }
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


//DraggableScrollableSheet would be fantastic for the patient gride view,
//otherwise, we would have to do filtering options...
//>> filter by: fname, lname, bday (age), brisk, frisk, room#, even length of
//stay or weight... but those last 2 probably would not be approrpiate for the
//context https://docs.flutter.dev/development/ui/widgets/interaction

//silvers are extremely neat too, check out CustomScrollView
//https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html