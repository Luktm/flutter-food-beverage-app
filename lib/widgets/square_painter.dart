import 'package:astro_test/utils/constant_util.dart';
import 'package:flutter/material.dart';

class SquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = K.primaryColor
      ..strokeWidth = 400;

    Path path = Path();
    path.addRRect(RRect.fromRectAndCorners(Rect.fromLTWH(0, 100, size.width / 4, size.height / 1.5), bottomRight: Radius.circular(30), topRight: Radius.circular(30)));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
