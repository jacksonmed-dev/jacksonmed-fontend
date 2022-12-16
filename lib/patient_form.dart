import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'patient_view.dart';
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36),
                controller: fnameController,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  icon: Icon(Icons.person),
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
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36),
                controller: lnameController,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  icon: Icon(Icons.person),
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
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36),
                controller: bdayController,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
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
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36),
                controller: heightController,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  icon: Icon(Icons.straighten),
                  labelText: 'Height (cm)',
                  hintText: 'ex: 165cm',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
              TextFormField(
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36),
                controller: weightController,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  icon: Icon(Icons.monitor_weight),
                  labelText: 'Weight (kg)',
                  hintText: 'ex: 85kg',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
              TextFormField(
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36),
                controller: sexController,
                decoration: const InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  icon: Icon(Icons.transgender),
                  labelText: 'Sex',
                  hintText: 'ex: Female',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: Size(128, 128)),
                  onPressed: () async {
                    if (_patientFormKey.currentState!.validate()) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const PatientView();
                          },
                        ),
                      );
                      /*
                      patient.fname = fnameController.text;
                      patient.lname = lnameController.text;
                      patient.bday = bdayController.text;
                      patient.height = heightController.text;
                      patient.weight = weightController.text;
                      patient.sex = sexController.text;
                      createPatient(patient);
        */
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid')),
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 64,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
