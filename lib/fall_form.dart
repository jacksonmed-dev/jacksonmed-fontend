import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FallForm extends StatefulWidget {
  const FallForm({super.key});

  @override
  State<FallForm> createState() => _FallFormState();
}

class _FallFormState extends State<FallForm> {
  final _bedsoreFormKey = GlobalKey<FormBuilderState>();

  List<String> yesNo = [
    'No', //cancel
    'Yes', //check circle
  ];

  //has [name] fallen in the last 3 months?
  //does [name] have more than 1 existing medical diagnosis?
  //does [name] currently have an IV?

  List<String> aidOptions = [
    //does [name] require assistance to walk?
    'None OR Wheelchair OR Bedridden',
    'Uses a Walking Device',
    'Relies on Furniture for Support',
  ];

  List<String> mobilityOptions = [
    //What is the quality of [name's] gait and balance?
    'Good or Immobile',
    'Stooped Posture',
    'Shuffles Steps',
  ];

  List<String> mentalOptions = [
    //what is the mental status of [name]?
    'Aware and Coherent', //psychology
    'Confused and/or Forgetful', //psychology alt or question mark
  ];

  int historyScore = 0;
  int secondaryScore = 0;
  int aidScore = 0;
  int ivScore = 0;
  int mobilityScore = 0;
  int mentalScore = 0;

  int fRisk = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Bedsore Risk Assessment')),
      ),
      body: FormBuilder(
        key: _bedsoreFormKey,
        child: Column(
          children: [
            FormBuilderChoiceChip<String>(
              decoration: const InputDecoration(
                labelText: 'Has [name] had a fall within the last 3 months?',
              ),
              name: 'history',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: yesNo[0],
                  avatar: const Icon(Icons.close),
                ),
                FormBuilderChipOption(
                  value: yesNo[1],
                  avatar: const Icon(Icons.check),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Select One';
                }
                historyScore = yesNo.indexOf(value) * 25;
                return null;
              },
            ),
            FormBuilderChoiceChip<String>(
              decoration: const InputDecoration(
                labelText:
                    'Does [name] currently have a seconday medical diagnosis?',
              ),
              name: 'secondary',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: yesNo[0],
                  avatar: const Icon(Icons.close),
                ),
                FormBuilderChipOption(
                  value: yesNo[1],
                  avatar: const Icon(Icons.check),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                secondaryScore = yesNo.indexOf(value) * 15;
                return null;
              },
            ),
            FormBuilderChoiceChip<String>(
              decoration: const InputDecoration(
                labelText: 'Does [name] require assistance to walk?',
              ),
              name: 'aid',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: aidOptions[0],
                  avatar: const Icon(Icons.wheelchair_pickup),
                ),
                FormBuilderChipOption(
                  value: aidOptions[1],
                  avatar: const Icon(Icons.elderly),
                ),
                FormBuilderChipOption(
                  value: aidOptions[2],
                  avatar: const Icon(Icons.chair),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                aidScore = aidOptions.indexOf(value) * 15;
                return null;
              },
            ),
            FormBuilderChoiceChip<String>(
              decoration: const InputDecoration(
                labelText: 'Is [name] currently using an IV?',
              ),
              name: 'iv',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: yesNo[0],
                  avatar: const Icon(Icons.close),
                ),
                FormBuilderChipOption(
                  value: yesNo[1],
                  avatar: const Icon(Icons.check),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                ivScore = yesNo.indexOf(value) * 20;
                return null;
              },
            ),
            FormBuilderChoiceChip<String>(
              decoration: const InputDecoration(
                labelText: 'What is the quality of [name] gait and balance?',
              ),
              name: 'mobility',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: mobilityOptions[0],
                  avatar: const Icon(Icons.directions_run),
                ),
                FormBuilderChipOption(
                  value: mobilityOptions[1],
                  avatar: const Icon(Icons.directions_walk),
                ),
                FormBuilderChipOption(
                  value: mobilityOptions[2],
                  avatar: const Icon(Icons.elderly),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                mobilityScore = mobilityOptions.indexOf(value) * 10;
                return null;
              },
            ),
            FormBuilderChoiceChip<String>(
              decoration: const InputDecoration(
                labelText: 'What is the mental status of [name]?',
              ),
              name: 'mental',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: mentalOptions[0],
                  avatar: const Icon(Icons.psychology),
                ),
                FormBuilderChipOption(
                  value: mentalOptions[1],
                  avatar: const Icon(Icons.help),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                mentalScore = mentalOptions.indexOf(value) * 15;
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_bedsoreFormKey.currentState!.validate()) {
                  fRisk = historyScore +
                      secondaryScore +
                      aidScore +
                      ivScore +
                      mobilityScore +
                      mentalScore;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        print(fRisk);
                        return const Text('');
//                        return const FallForm();
                      },
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid')),
                  );
                }
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
