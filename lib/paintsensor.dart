import 'package:flutter/material.dart';

const w = 27.0;
const h = 64.0;
const scale = 10.0;

class SensorPainter extends CustomPainter {
  List<int> sensorData = [];
  SensorPainter(this.sensorData);

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = 0; i < h; i++) {
      for (double j = 0; j < w; j++) {
        int c = sensorData[(i * w + j).round()];
        var paint = Paint()
          ..color = Color.fromARGB(255, c, c, c)
//          ..color = Colors.red.withRed(sensorData[(i * w + j).round()])
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.square;

        Offset center =
            Offset((scale * j) - (w * scale / 2), scale * i - (h * scale / 2));

        Rect sensor = Rect.fromCenter(
          center: center,
          width: scale,
          height: scale,
        );

//        Rect sensor = Offset(scale * j, scale * i) & const Size(scale, scale);

        canvas.drawRect(sensor, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
