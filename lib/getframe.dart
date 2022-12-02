// To parse this JSON data, do
//
//     final frame = frameFromJson(jsonString);

import 'dart:convert';

Frame frameFromJson(String str) => Frame.fromJson(json.decode(str));

class Frame {
  Frame({
    required this.id,
    required this.time,
    required this.readings,
  });

  int id;
  DateTime time;
  List<int> readings;

  factory Frame.fromJson(Map<String, dynamic> json) => Frame(
        id: json["id"],
        time: DateTime.parse(json["time"]),
        readings: List<int>.from(json["readings"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time.toIso8601String(),
        "readings": List<dynamic>.from(readings.map((x) => x)),
      };
}
