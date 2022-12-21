import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'bedsore_form.dart';
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

//  final apiurl = 'https://test.api.jacksonmed.org/patient';

  Patient patient = Patient(
    fname: '',
    lname: '',
    bday: '',
    height: '',
    weight: '',
    sex: '',
    fRisk: 0,
    bRisk: 0,
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

/*
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
*/

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
            children: <Widget>[
              TextFormField(
                controller: fnameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.badge_outlined),
                  labelText: 'First Name',
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
                  icon: Icon(Icons.badge_outlined),
                  labelText: 'Last Name',
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
                  icon: Icon(Icons.calendar_month),
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
                  icon: Icon(Icons.straighten),
                  labelText: 'Height (cm)',
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
                  icon: Icon(Icons.fitness_center),
                  labelText: 'Weight (kg)',
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
                  icon: Icon(Icons.transgender),
                  labelText: 'Sex',
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
                  style: ElevatedButton.styleFrom(fixedSize: Size(128, 64)),
                  onPressed: () async {
                    if (_patientFormKey.currentState!.validate()) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const NortonScale();
                          },
                        ),
                      );

                      patient.fname = fnameController.text;
                      patient.lname = lnameController.text;
                      patient.bday = bdayController.text;
                      patient.height = heightController.text;
                      patient.weight = weightController.text;
                      patient.sex = sexController.text;
//                      createPatient(patient);

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
