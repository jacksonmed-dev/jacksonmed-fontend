import 'dart:convert';

Frame frameFromJson(String str) {
  String raw = str.substring(1, str.length - 1);
  String parse1 = raw.substring(1, raw.length - 1);
  String parse2 = parse1.replaceAll('[ [ ', '[');
  String parse3 = parse2.replaceAll(' ] ]', ']');
  return Frame.fromJson(json.decode(parse3));
}

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
}
