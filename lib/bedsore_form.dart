import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'patients.dart';
import 'fall_form.dart';

class BedsoreForm extends StatefulWidget {
  final User user;
  const BedsoreForm({super.key, required this.user});

  @override
  State<BedsoreForm> createState() => _BedsoreFormState();
}

class _BedsoreFormState extends State<BedsoreForm> {
  final _bedsoreFormKey = GlobalKey<FormBuilderState>();

  List<String> sensoryOptions = [
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
                  value: sensoryOptions[3],
                  avatar: const Icon(Icons.sentiment_satisfied_outlined),
                ),
                FormBuilderChipOption(
                  value: sensoryOptions[2],
                  avatar: const Icon(Icons.sentiment_neutral_outlined),
                ),
                FormBuilderChipOption(
                  value: sensoryOptions[1],
                  avatar: const Icon(Icons.sentiment_dissatisfied_outlined),
                ),
                FormBuilderChipOption(
                  value: sensoryOptions[0],
                  avatar: const Icon(Icons.close),
                ),
              ],
              validator: (value) {
                if (value == null) {
                  return 'Select One';
                }
                widget.user.bScores.sensoryScore =
                    sensoryOptions.indexOf(value) + 1;
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
                widget.user.bScores.moistureScore =
                    moistureOptions.indexOf(value) + 1;
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
                widget.user.bScores.activityScore =
                    activityOptions.indexOf(value) + 1;
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
                widget.user.bScores.mobilityScore =
                    mobilityOptions.indexOf(value) + 1;
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
                widget.user.bScores.nutritionScore =
                    nutritionOptions.indexOf(value) + 1;
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
                widget.user.bScores.assistanceScore =
                    assistanceOptions.indexOf(value) + 1;
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_bedsoreFormKey.currentState!.validate()) {
                  widget.user.patient.bRisk =
                      (widget.user.bScores.sensoryScore +
                              widget.user.bScores.moistureScore +
                              widget.user.bScores.activityScore +
                              widget.user.bScores.mobilityScore +
                              widget.user.bScores.nutritionScore +
                              widget.user.bScores.assistanceScore)
                          .toString();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FallForm(user: widget.user);
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
