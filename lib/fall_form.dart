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
    'No Aid or Immobile',
    'Some Aid Required',
    'Extensive Aid Required',
  ];

  List<String> mobilityOptions = [
    //What is the quality of [name's] gait and balance?
    'Good or Immobile',
    'Fair',
    'Very Poor',
  ];

  List<String> mentalOptions = [
    //what is the mental status of [name]?
    'Aware and/or Coherent', //psychology
    'Confused and/or Forgetful', //psychology alt or question mark
  ];

  int sensationScore = 0;
  int moistureScore = 0;
  int activityScore = 0;
  int mobilityScore = 0;
  int nutritionScore = 0;
  int assistanceScore = 0;

  int bRisk = 0;

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
                labelText: 'Sensory Perception',
              ),
              name: 'sense',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: yesNo[3],
                  avatar: const Icon(Icons.sentiment_satisfied_outlined),
                ),
                FormBuilderChipOption(
                  value: yesNo[2],
                  avatar: const Icon(Icons.sentiment_neutral_outlined),
                ),
                FormBuilderChipOption(
                  value: yesNo[1],
                  avatar: const Icon(Icons.sentiment_dissatisfied_outlined),
                ),
                FormBuilderChipOption(
                  value: yesNo[0],
                  avatar: const Icon(Icons.close),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Select One';
                }
                sensationScore = yesNo.indexOf(value) + 1;
                return null;
              },
            ),
            FormBuilderChoiceChip<String>(
              decoration: const InputDecoration(
                labelText: 'Skin Moisture',
              ),
              name: 'moist',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: yesNo[3],
                  avatar: const Icon(Icons.format_color_reset_outlined),
                ),
                FormBuilderChipOption(
                  value: yesNo[2],
                  avatar: const Icon(Icons.water_drop_outlined),
                ),
                FormBuilderChipOption(
                  value: yesNo[1],
                  avatar: const Icon(Icons.opacity),
                ),
                FormBuilderChipOption(
                  value: yesNo[0],
                  avatar: const Icon(Icons.water_drop),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                moistureScore = yesNo.indexOf(value) + 1;
                return null;
              },
            ),
            FormBuilderChoiceChip<String>(
              decoration: const InputDecoration(
                labelText: 'Activity Level',
              ),
              name: 'active',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: aidOptions[3],
                  avatar: const Icon(Icons.directions_run),
                ),
                FormBuilderChipOption(
                  value: aidOptions[2],
                  avatar: const Icon(Icons.directions_walk),
                ),
                FormBuilderChipOption(
                  value: aidOptions[1],
                  avatar: const Icon(Icons.airline_seat_recline_normal),
                ),
                FormBuilderChipOption(
                  value: aidOptions[0],
                  avatar: const Icon(Icons.hotel),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                activityScore = aidOptions.indexOf(value) + 1;
                return null;
              },
            ),
            FormBuilderChoiceChip<String>(
              decoration: const InputDecoration(
                labelText: 'Mobility',
              ),
              name: 'mobile',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: yesNo[3],
                  avatar: const Icon(Icons.zoom_out_map),
                ),
                FormBuilderChipOption(
                  value: yesNo[2],
                  avatar: const Icon(Icons.multiple_stop),
                ),
                FormBuilderChipOption(
                  value: yesNo[1],
                  avatar: const Icon(Icons.mobiledata_off),
                ),
                FormBuilderChipOption(
                  value: yesNo[0],
                  avatar: const Icon(Icons.block),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                mobilityScore = yesNo.indexOf(value) + 1;
                return null;
              },
            ),
            FormBuilderChoiceChip<String>(
              decoration: const InputDecoration(
                labelText: 'Nutrition',
              ),
              name: 'nutrient',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: mobilityOptions[3],
                  avatar: const Icon(Icons.fastfood),
                ),
                FormBuilderChipOption(
                  value: mobilityOptions[2],
                  avatar: const Icon(Icons.lunch_dining),
                ),
                FormBuilderChipOption(
                  value: mobilityOptions[1],
                  avatar: const Icon(Icons.local_pizza_outlined),
                ),
                FormBuilderChipOption(
                  value: mobilityOptions[0],
                  avatar: const Icon(Icons.no_food),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                nutritionScore = mobilityOptions.indexOf(value) + 1;
                return null;
              },
            ),
            FormBuilderChoiceChip<String>(
              decoration: const InputDecoration(
                labelText: 'Assistance Required',
              ),
              name: 'assist',
              selectedColor: Colors.blue,
              options: [
                FormBuilderChipOption(
                  value: mentalOptions[2],
                  avatar: const Icon(Icons.accessibility),
                ),
                FormBuilderChipOption(
                  value: mentalOptions[1],
                  avatar: const Icon(Icons.people),
                ),
                FormBuilderChipOption(
                  value: mentalOptions[0],
                  avatar: const Icon(Icons.sports_kabaddi),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                assistanceScore = mentalOptions.indexOf(value) + 1;
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_bedsoreFormKey.currentState!.validate()) {
                  bRisk = sensationScore +
                      moistureScore +
                      activityScore +
                      mobilityScore +
                      nutritionScore +
                      assistanceScore;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        print(bRisk);
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
