import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BradenForm extends StatefulWidget {
  const BradenForm({super.key});

  @override
  State<BradenForm> createState() => _BedsoreFormV2State();
}

class _BedsoreFormV2State extends State<BradenForm> {
  final _bedsoreFormKey = GlobalKey<FormBuilderState>();

  List<String> sensationOptions = [
    'Unresponsive',
    'Extensive Impairment',
    'Slight Impairment',
    'Responsive',
  ];

  List<String> moistureOptions = [
    'Constantly Moist',
    'Often Moist',
    'Sometimes Moist',
    'Rarely Moist',
  ];

  List<String> activityOptions = [
    'Bedridden',
    'Mostly Inactive',
    'Somewhat Active',
    'Very Active',
  ];

  List<String> mobilityOptions = [
    'Completely Immobile',
    'Very Limited',
    'Slightly Limited',
    'No Limitations',
  ];

  List<String> nutritionOptions = [
    'Poor',
    'Fair',
    'Good',
    'Excellent',
  ];

  List<String> assistanceOptions = [
    'Extensive',
    'Some',
    'Independent',
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
                  value: sensationOptions[3],
                  avatar: const Icon(Icons.sentiment_satisfied_outlined),
                ),
                FormBuilderChipOption(
                  value: sensationOptions[2],
                  avatar: const Icon(Icons.sentiment_neutral_outlined),
                ),
                FormBuilderChipOption(
                  value: sensationOptions[1],
                  avatar: const Icon(Icons.sentiment_dissatisfied_outlined),
                ),
                FormBuilderChipOption(
                  value: sensationOptions[0],
                  avatar: const Icon(Icons.close),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Select One';
                }
                sensationScore = sensationOptions.indexOf(value) + 1;
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
                  value: moistureOptions[3],
                  avatar: const Icon(Icons.format_color_reset_outlined),
                ),
                FormBuilderChipOption(
                  value: moistureOptions[2],
                  avatar: const Icon(Icons.water_drop_outlined),
                ),
                FormBuilderChipOption(
                  value: moistureOptions[1],
                  avatar: const Icon(Icons.opacity),
                ),
                FormBuilderChipOption(
                  value: moistureOptions[0],
                  avatar: const Icon(Icons.water_drop),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                moistureScore = moistureOptions.indexOf(value) + 1;
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
                  value: activityOptions[3],
                  avatar: const Icon(Icons.directions_run),
                ),
                FormBuilderChipOption(
                  value: activityOptions[2],
                  avatar: const Icon(Icons.directions_walk),
                ),
                FormBuilderChipOption(
                  value: activityOptions[1],
                  avatar: const Icon(Icons.airline_seat_recline_normal),
                ),
                FormBuilderChipOption(
                  value: activityOptions[0],
                  avatar: const Icon(Icons.hotel),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                activityScore = activityOptions.indexOf(value) + 1;
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
                  value: mobilityOptions[3],
                  avatar: const Icon(Icons.zoom_out_map),
                ),
                FormBuilderChipOption(
                  value: mobilityOptions[2],
                  avatar: const Icon(Icons.multiple_stop),
                ),
                FormBuilderChipOption(
                  value: mobilityOptions[1],
                  avatar: const Icon(Icons.mobiledata_off),
                ),
                FormBuilderChipOption(
                  value: mobilityOptions[0],
                  avatar: const Icon(Icons.block),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                mobilityScore = mobilityOptions.indexOf(value) + 1;
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
                  value: nutritionOptions[3],
                  avatar: const Icon(Icons.fastfood),
                ),
                FormBuilderChipOption(
                  value: nutritionOptions[2],
                  avatar: const Icon(Icons.lunch_dining),
                ),
                FormBuilderChipOption(
                  value: nutritionOptions[1],
                  avatar: const Icon(Icons.local_pizza_outlined),
                ),
                FormBuilderChipOption(
                  value: nutritionOptions[0],
                  avatar: const Icon(Icons.no_food),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                nutritionScore = nutritionOptions.indexOf(value) + 1;
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
                  value: assistanceOptions[2],
                  avatar: const Icon(Icons.accessibility),
                ),
                FormBuilderChipOption(
                  value: assistanceOptions[1],
                  avatar: const Icon(Icons.people),
                ),
                FormBuilderChipOption(
                  value: assistanceOptions[0],
                  avatar: const Icon(Icons.sports_kabaddi),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Invalid';
                }
                assistanceScore = assistanceOptions.indexOf(value) + 1;
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
//                        return const BradenForm();
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
