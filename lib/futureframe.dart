import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Frame> fetchFrame() async {
  String url = 'http://192.168.1.34/api/frames';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    String raw = response.body.substring(1, response.body.length - 1);
    String parse1 = raw.substring(1, raw.length - 1);
    String parse2 = parse1.replaceAll('[ [ ', '[');
    String parse3 = parse2.replaceAll(' ] ]', ']');
    print(parse3);
    return Frame.fromJson(jsonDecode(parse3));
  } else {
    throw Exception('Failed to load Frame');
  }
}

class Frame {
  int id;
  String time;
  List<int> readings;

  Frame({
    required this.id,
    required this.time,
    required this.readings,
  });

  factory Frame.fromJson(Map<String, dynamic> json) {
    return Frame(
      id: json['id'],
      time: json['time'],
      readings: json['readings'].cast<int>(),
    );
  }
}
