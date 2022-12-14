class Patient {
  String fname;
  String lname;
  String bday; //DateTime
  String height; //double (cm)
  String weight; //double (kg)
  String sex;
//  int brisk
//  int frisk

  Patient({
    required this.fname,
    required this.lname,
    required this.bday,
    required this.height,
    required this.weight,
    required this.sex,
  });
}
