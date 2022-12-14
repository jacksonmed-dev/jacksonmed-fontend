import 'package:flutter/material.dart';

const w = 27.0;
const h = 64.0;

class SensorPainter extends CustomPainter {
  List<int> sensorData = [];
  SensorPainter(this.sensorData);

  @override
  void paint(Canvas canvas, Size size) {
    Color? color;
    for (double i = 0; i < h; i++) {
      for (double j = 0; j < w; j++) {
        int c = sensorData[(i * w + j).round()];

        if (c >= 0 && c <= 20) {
          color = Color.lerp(Colors.white, Colors.blue, c / 20);
        } else if (c > 20 && c <= 40) {
          color = Color.lerp(Colors.blue, Colors.green, (c - 20) / 20);
        } else if (c > 40 && c <= 60) {
          color = Color.lerp(Colors.green, Colors.yellow, (c - 40) / 20);
        } else if (c > 60 && c <= 80) {
          color = Color.lerp(Colors.yellow, Colors.orange, (c - 60) / 20);
        } else if (c > 80 && c <= 100) {
          color = Color.lerp(Colors.orange, Colors.red, (c - 80) / 20);
        } else {
          color = Colors.white;
        }

        var paint = Paint()
          ..color = color!
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.square;

        Offset center = Offset(j - w / 2, i - h / 2);

        Rect sensor = Rect.fromCenter(
          center: center,
          width: 1,
          height: 1,
        );

        canvas.drawRect(sensor, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
