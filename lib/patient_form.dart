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

  final roomController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final sexController = TextEditingController();
  final bRiskController = TextEditingController();
  final fRiskController = TextEditingController();
  final sIdController = TextEditingController();
  final fIdController = TextEditingController();
  final pIdController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final bDayController = TextEditingController();

  List<DropdownMenuItem<String>> get sexItems {
    List<DropdownMenuItem<String>> sexes = [
      const DropdownMenuItem(value: "Male", child: Text("Male")),
      const DropdownMenuItem(value: "Female", child: Text("Female")),
      const DropdownMenuItem(value: "Other", child: Text("Other")),
    ];
    return sexes;
  }

//  final apiurl = 'https://test.api.jacksonmed.org/patient';

  Patient patient = Patient(
    room: '',
    height: '',
    weight: '',
    sex: '',
    bRisk: '',
    fRisk: '',
    sId: '',
    fId: '',
    pId: '',
    fName: '',
    lName: '',
    bDay: '',
  );

  @override
  void initState() {
    roomController.text = '';
    heightController.text = '';
    weightController.text = '';
    sexController.text = '';
    bRiskController.text = '';
    fRiskController.text = '';
    sIdController.text = '';
    fIdController.text = '';
    pIdController.text = '';
    fNameController.text = '';
    lNameController.text = '';
    bDayController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    roomController.dispose();
    heightController.dispose();
    weightController.dispose();
    sexController.dispose();
    bRiskController.dispose();
    fRiskController.dispose();
    sIdController.dispose();
    fIdController.dispose();
    pIdController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    bDayController.dispose();
    super.dispose();
  }

/*
  Future<http.Response> createPatient(Patient p) {
    return http.post(
      Uri.parse(apiurl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "bedsoreRisk": p.bRisk,
        "birthday": p.bday,
        "fallRisk": p.fRisk,
        "firstName": p.fname,
        "height": p.height,
        "lastName": p.lname,
        "roomId": p.room,
        "sex": p.sex,
        "weight": p.weight,
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
                controller: fNameController,
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
                controller: lNameController,
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
                controller: bDayController,
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
                      bDayController.text = formattedDate;
                    });
                  }
                },
              ),
              TextFormField(
                //scroll wheel with options for ft & in or cm
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
                //scroll wheel with options for kg or lbs
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
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.transgender),
                  labelText: 'Sex',
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      sexController.text = value;
                    });
                  }
                },
                items: sexItems,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select Sex';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_patientFormKey.currentState!.validate()) {
                      patient.fName = fNameController.text;
                      patient.lName = lNameController.text;
                      patient.bDay = bDayController.text;
                      patient.height = heightController.text;
                      patient.weight = weightController.text;
                      patient.sex = sexController.text;
//                      createPatient(patient);

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const BedsoreForm();
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid')),
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
