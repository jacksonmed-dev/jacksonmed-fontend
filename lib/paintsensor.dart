import 'package:flutter/material.dart';

const w = 27.0;
const h = 64.0;
const scale = 10.0;

class SensorPainter extends CustomPainter {
  List<int> sensorData = [];
  SensorPainter(this.sensorData);

  @override
  void paint(Canvas canvas, Size size) {
    int r;
    int g;
    int b;
    for (double i = 0; i < h; i++) {
      for (double j = 0; j < w; j++) {
        int c = sensorData[(i * w + j).round()];

        if (c >= 0 && c <= 20) {
          //white -> blue
          r = 255 - ((c / 20) * 255).round();
          g = 255 - ((c / 20) * 255).round();
          b = 255;
        } else if (c > 20 && c <= 40) {
          //blue -> cyan
          c = c - 20;
          r = 0;
          g = ((c / 20) * 255).round();
          b = 255;
        } else if (c > 40 && c <= 60) {
          //cyan -> green
          c = c - 40;
          r = 0;
          g = 255;
          b = 255 - ((c / 20) * 255).round();
        } else if (c > 60 && c <= 80) {
          //green -> yellow
          c = c - 60;
          r = ((c / 20) * 255).round();
          g = 255;
          b = 0;
        } else if (c > 80) {
          //yellow -> red
          c = c - 80;
          r = 255;
          g = 255 - ((c / 20) * 255).round();
          b = 0;
        } else {
          //safety
          r = 255;
          g = 255;
          b = 255;
        }

/*
        if (c > 0 && c < 26) {
          r = 0;
          g = ((c / 25) * 255).round();
          b = 255;
        } else if (c > 25 && c < 51) {
          r = 0;
          g = 255;
          b = 255 - ((c / 50) * 255).round();
        } else if (c > 50 && c < 76) {
          r = ((c / 75) * 255).round();
          g = 255;
          b = 0;
        } else if (c > 75) {
          r = 255;
          g = 255 - ((c / 100) * 255).round();
          b = 0;
        } else {
          r = 255;
          g = 255;
          b = 255;
        }
*/
        var paint = Paint()
          ..color = Color.fromARGB(255, r, g, b)
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.square;

        Offset center =
            Offset((scale * j) - (w * scale / 2), scale * i - (h * scale / 2));

        Rect sensor = Rect.fromCenter(
          center: center,
          width: scale,
          height: scale,
        );

        canvas.drawRect(sensor, paint);
      }
    }
//    canvas.drawColor(Colors.white, BlendMode.color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
