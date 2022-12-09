import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'ducky.dart';

Future<ui.Image> image = decodeImageFromList(data);

class FacePainter extends CustomPainter {
  FacePainter(this.image);
  final ui.Image image;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) => image != oldDelegate.image;
}
