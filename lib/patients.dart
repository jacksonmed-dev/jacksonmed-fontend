import 'dart:math';

class Patient {
  String fname;
  String lname;
  String bday; //DateTime
  String height; //double (cm)
  String weight; //double (kg)
  String sex;
//  int brisk (Braden -or- Norton)
//  int frisk (Morse -or-  WSFRAT)

  Patient({
    required this.fname,
    required this.lname,
    required this.bday,
    required this.height,
    required this.weight,
    required this.sex,
  });
}

final List<String> name = [
  'Obi-Wan Kenobi',
  'Darth Vador',
  'Han Solo',
];

List<String> bday = [
  '${Random().nextInt(11) + 1}/${Random().nextInt(29) + 1}/${Random().nextInt(82) + 1922}',
  '${Random().nextInt(11) + 1}/${Random().nextInt(29) + 1}/${Random().nextInt(82) + 1922}',
  '${Random().nextInt(11) + 1}/${Random().nextInt(29) + 1}/${Random().nextInt(82) + 1922}',
];

final List<int> height = [
  //140cm - 200cm
  Random().nextInt(60) + 140,
  Random().nextInt(60) + 140,
  Random().nextInt(60) + 140,
];

final List<int> weight = [
  //40kg - 160kg
  Random().nextInt(120) + 40,
  Random().nextInt(120) + 40,
  Random().nextInt(120) + 40,
];

List<int> sex = [
  //1 = male, 0 = female
  Random().nextInt(1),
  Random().nextInt(1),
  Random().nextInt(1),
];

List<double> bRisk = [
  //0.0 - 1.0
  Random().nextDouble(),
  Random().nextDouble(),
  Random().nextDouble(),
];

List<int> asleep = [
  //1 = true, 0 = false
  Random().nextInt(1),
  Random().nextInt(1),
  Random().nextInt(1),
];

List<int> inBed = [
  //1 = true, 0 = false
  Random().nextInt(1),
  Random().nextInt(1),
  Random().nextInt(1),
];

List<int> room = [
  Random().nextInt(99) + 1,
  Random().nextInt(99) + 1,
  Random().nextInt(99) + 1,
];

List<int> hr = [
  Random().nextInt(40) + 60,
  Random().nextInt(40) + 60,
  Random().nextInt(40) + 60,
];

List<int> rr = [
  Random().nextInt(20) + 10,
  Random().nextInt(20) + 10,
  Random().nextInt(20) + 10,
];
