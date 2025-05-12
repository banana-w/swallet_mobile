import 'dart:math';

import 'package:flutter/material.dart';

class NavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final h5 = h * 0.5, w5 = w * 0.5;
    final h6 = h * 0.6;
    final double radius = 10;

    //path clipper
    final path = Path()
      ..lineTo(w5 - 80, 0)
      ..cubicTo(w5 - 30, 0, w5 - 50, h5 + 10, w5 - 3, h6 + 5)
      ..lineTo(w5, h)
      ..lineTo(w, h)
      ..lineTo(w, 0)
      ..lineTo(w5 + 80, 0)
      ..cubicTo(w5 + 30, 0, w5 + 50, h5 + 10, w5 + 3, h6 + 5)
      ..lineTo(w5 - 3, h6 + 5)
      ..lineTo(w5, h)
      ..lineTo(0, h);

    //path rounded rectangle
    final Path pathRec = Path()
      ..moveTo(radius, 0)
      ..lineTo(w - radius, 0)
      //draw the top-right corner
      ..arcTo(
        Rect.fromCircle(center: Offset(w - radius, radius), radius: radius),
        -pi / 2,
        pi / 2,
        false,
      )
      //draw the right line
      ..lineTo(w, h - radius)
      //draw the bottom-right corner
      ..arcTo(
        Rect.fromCircle(center: Offset(w - radius, h - radius), radius: radius),
        0,
        pi / 2,
        false,
      )
      // Draw the bottom line
      ..lineTo(radius, h)
      // Draw the bottom-left corner
      ..arcTo(
        Rect.fromCircle(center: Offset(radius, h - radius), radius: radius),
        pi / 2,
        pi / 2,
        false,
      )
      // Draw the left line
      ..lineTo(0, radius)
      // Draw the top-left corner
      ..arcTo(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        pi,
        pi / 2,
        false,
      )
      // Close the path
      ..close();

    final Paint paint = Paint()..color = Color(0xFF0E4B5A);

    //draw shadow
    canvas.drawShadow(Path.combine(PathOperation.intersect, path, pathRec),
        Color.fromARGB(255, 74, 74, 74), 20, false);
    //draw Path
    canvas.drawPath(Path.combine(PathOperation.intersect, path, pathRec), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
