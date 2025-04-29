import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ProfilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.8214200, size.height * 0.2672907);
    path.cubicTo(
        size.width * 0.8214200,
        size.height * 0.4124349,
        size.width * 0.6784457,
        size.height * 0.5288163,
        size.width * 0.5000000,
        size.height * 0.5288163);
    path.cubicTo(
        size.width * 0.3216143,
        size.height * 0.5288163,
        size.width * 0.1785794,
        size.height * 0.4124349,
        size.width * 0.1785794,
        size.height * 0.2672907);
    path.cubicTo(
        size.width * 0.1785794,
        size.height * 0.1221465,
        size.width * 0.3216143,
        size.height * 0.005813953,
        size.width * 0.5000000,
        size.height * 0.005813953);
    path.cubicTo(
        size.width * 0.6784457,
        size.height * 0.005813953,
        size.width * 0.8214200,
        size.height * 0.1221465,
        size.width * 0.8214200,
        size.height * 0.2672907);
    path.close();
    path.moveTo(size.width * 0.5000000, size.height * 0.9941860);
    path.cubicTo(
        size.width * 0.2366440,
        size.height * 0.9941860,
        size.width * 0.01428571,
        size.height * 0.9593465,
        size.width * 0.01428571,
        size.height * 0.8249256);
    path.cubicTo(
        size.width * 0.01428571,
        size.height * 0.6904558,
        size.width * 0.2380411,
        size.height * 0.6568512,
        size.width * 0.5000000,
        size.height * 0.6568512);
    path.cubicTo(
        size.width * 0.7634171,
        size.height * 0.6568512,
        size.width * 0.9857143,
        size.height * 0.6916907,
        size.width * 0.9857143,
        size.height * 0.8261116);
    path.cubicTo(
        size.width * 0.9857143,
        size.height * 0.9605814,
        size.width * 0.7619600,
        size.height * 0.9941860,
        size.width * 0.5000000,
        size.height * 0.9941860);
    path.close();
    Paint painter = Paint()..style = PaintingStyle.fill;
    painter.shader = ui.Gradient.linear(
        Offset(size.width * 1.428571, size.height * 0.5813953),
        Offset(size.width * 0.9330057, size.height * 2.211184), [
      const Color(0xff1FA0BD).withOpacity(1),
      const Color(0xff5FD8F3).withOpacity(1)
    ], [
      0,
      1
    ]);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
