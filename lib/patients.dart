class Patient {
  String room;
  String height;
  String weight;
  String sex;
  String bRisk;
  String fRisk;
  String sId;
  String fId;
  String pId;
  String fName;
  String lName;
  String bDay;

  Patient({
    required this.fName,
    required this.lName,
    required this.bDay,
    required this.height,
    required this.weight,
    required this.sex,
    required this.bRisk,
    required this.fRisk,
    required this.room,
    required this.sId,
    required this.fId,
    required this.pId,
  });
}

 //(Morse -or-  WSFRAT) for fRisk
 //(Braden -or- Norton -or- Waterlow) for bRisk