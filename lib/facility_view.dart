import 'dart:math';

import 'package:flutter/material.dart';

import 'patient_form.dart';
import 'patients.dart';

class FacilityView extends StatefulWidget {
  const FacilityView({super.key});

  @override
  State<FacilityView> createState() => _FacilityViewState();
}

class _FacilityViewState extends State<FacilityView> {
  final facilityName = 'Jackson Medical Solutions';
  final List<String> name = <String>[
    'Obi-Wan Kenobi',
    'Darth Vador',
    'Han Solo',
  ];

  final List<double> height = [
    Random().nextInt(210) + 90,
    Random().nextInt(210) + 90,
    Random().nextInt(210) + 90,
  ];

  final List<double> weight = [
    Random().nextInt(210) + 90,
    Random().nextInt(210) + 90,
    Random().nextInt(210) + 90,
  ];

  List<String> sex = [];

  List<double> brisk = [
    Random().nextDouble(),
    Random().nextDouble(),
    Random().nextDouble(),
  ];

  List<int> inBed = [
    Random().nextInt(1),
    Random().nextInt(1),
    Random().nextInt(1),
  ];

  List<int> asleep = [
    Random().nextInt(1),
    Random().nextInt(1),
    Random().nextInt(1),
  ];

  List<int> hr = [];
  List<int> rr = [];

  List<String> bday = [];
  //Sould probably be List<DateTime>

  void newVitals() async {
    List<int> newHR = [
      Random().nextInt(40) + 60,
      Random().nextInt(40) + 60,
      Random().nextInt(40) + 60,
    ];
    List<int> newRR = [
      Random().nextInt(20) + 10,
      Random().nextInt(20) + 10,
      Random().nextInt(20) + 10,
    ];

    //asleep||awake and in||out and weight would really be async
    setState(() {
      hr = newHR;
      rr = newRR;
    });
  }

  void bdaySex() async {
    int m;
    int d;
    int y;
    int x;
    List<String> newBday = [];
    List<String> newSex = [];
    for (var i = 0; i < 3; i++) {
      m = Random().nextInt(11) + 1;
      d = Random().nextInt(29) + 1;
      y = Random().nextInt(82) + 1992;
      newBday[i] = '$m/$d/$y';
      x = Random().nextInt(1);
      if (x == 0) {
        newSex[i] = 'Male';
      } else {
        newSex[i] = 'Female';
      }
    }
    setState(() {
      bday = newBday;
      sex = newSex;
    });
  }

  @override
  void initState() {
    bdaySex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    newVitals();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('$facilityName Overview')),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: name.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 0,
            height: 256,
            color: Color.lerp(Colors.green, Colors.red, brisk[index]),
            child: Center(child: Text('Entry ${name[index]}')),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 16,
        ),
      ),
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
        child: const Icon(Icons.library_add),
      ),
    );
  }
}
