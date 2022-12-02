// To parse this JSON data, do
//
//     final sample = sampleFromJson(jsonString);
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  String url = "http://192.168.1.34/api/frames";
  final response = await http.get(Uri.parse(url));
  print(response.body);

  final sample = sampleFromJson(response.body);
}

List<Sample> sampleFromJson(String str) =>
    List<Sample>.from(json.decode(str).map((x) => Sample.fromJson(x)));

String sampleToJson(List<Sample> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sample {
  Sample({
    required this.id,
    required this.time,
    required this.readings,
  });

  int id;
  DateTime time;
  List<List<int>> readings;

  factory Sample.fromJson(Map<String, dynamic> json) => Sample(
        id: json["id"],
        time: DateTime.parse(json["time"]),
        readings: List<List<int>>.from(
            json["readings"].map((x) => List<int>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time.toIso8601String(),
        "readings": List<dynamic>.from(
            readings.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
