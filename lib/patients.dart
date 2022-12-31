class User {
  Patient patient;
  BScores bScores;
  FScores fScores;

  User({
    required this.patient,
    required this.bScores,
    required this.fScores,
  });
}

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

class BScores {
  int sensoryScore;
  int moistureScore;
  int activityScore;
  int mobilityScore;
  int nutritionScore;
  int assistanceScore;

  BScores({
    required this.sensoryScore,
    required this.moistureScore,
    required this.activityScore,
    required this.mobilityScore,
    required this.nutritionScore,
    required this.assistanceScore,
  });
}

class FScores {
  int historyScore;
  int secondaryScore;
  int aidScore;
  int ivScore;
  int mobilityScore;
  int mentalScore;

  FScores({
    required this.historyScore,
    required this.secondaryScore,
    required this.aidScore,
    required this.ivScore,
    required this.mobilityScore,
    required this.mentalScore,
  });
}


 //(Morse -or-  WSFRAT) for fRisk
 //(Braden -or- Norton -or- Waterlow) for bRisk