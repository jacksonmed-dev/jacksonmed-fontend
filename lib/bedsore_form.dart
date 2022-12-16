import 'package:flutter/material.dart';

class NortonScale extends StatefulWidget {
  const NortonScale({super.key});

  @override
  State<NortonScale> createState() => _NortonScaleState();
}

class _NortonScaleState extends State<NortonScale> {
  double _currentPhysical = 1;
  double _currentMental = 1;
  double _currentActivity = 1;
  double _currentMobility = 1;
  double _currentIncontinent = 1;

  final List<String> physical = ['Good', 'Fair', 'Bad', 'Very Bad'];
  final List<String> mental = ['Alert', 'Unaware', 'Confused', 'Incoherent'];
  final List<String> activity = [
    'Active',
    'Inactive',
    'Very Inactive',
    'Bedridden'
  ];
  final List<String> mobility = [
    'Not Limited',
    'Slightly Limited',
    'Very Limited',
    'Immobile'
  ];
  final List<String> incontinent = ['Never', 'Sometimes', 'Often', 'Always'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Bedsore Risk'))),
        body: Column(
          children: [
            Column(
              children: [
                const Text('Physical Activity'),
                Slider(
                  value: _currentPhysical,
                  min: 1,
                  max: 4,
                  divisions: 3,
                  label: physical[_currentPhysical.round() - 1],
                  onChanged: (double value) {
                    setState(() {
                      _currentPhysical = value;
                    });
                  },
                ),
              ],
            ),
            Column(
              children: [
                const Text('Mental State'),
                Slider(
                  value: _currentMental,
                  min: 1,
                  max: 4,
                  divisions: 3,
                  label: mental[_currentMental.round() - 1],
                  onChanged: (double value) {
                    setState(() {
                      _currentMental = value;
                    });
                  },
                ),
              ],
            ),
            Column(
              children: [
                const Text('Activity Level'),
                Slider(
                  value: _currentActivity,
                  min: 1,
                  max: 4,
                  divisions: 3,
                  label: activity[_currentActivity.round() - 1],
                  onChanged: (double value) {
                    setState(() {
                      _currentActivity = value;
                    });
                  },
                ),
              ],
            ),
            Column(
              children: [
                const Text('Mobility Level'),
                Slider(
                  value: _currentMobility,
                  min: 1,
                  max: 4,
                  divisions: 3,
                  label: mobility[_currentMobility.round() - 1],
                  onChanged: (double value) {
                    setState(() {
                      _currentMobility = value;
                    });
                  },
                ),
              ],
            ),
            Column(
              children: [
                const Text('Is the Patient Incontinent?'),
                Slider(
                  value: _currentIncontinent,
                  min: 1,
                  max: 4,
                  divisions: 3,
                  label: incontinent[_currentIncontinent.round() - 1],
                  onChanged: (double value) {
                    setState(() {
                      _currentIncontinent = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
