import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, 0);

    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 30);
    final lastCurve = Offset(40, size.height - 30);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondCurve = Offset(size.width - 40, size.height - 30);
    final thirdCurve = Offset(size.width - 40, size.height - 30);
    path.quadraticBezierTo(
        secondCurve.dx, secondCurve.dy, thirdCurve.dx, thirdCurve.dy);

    final lastCurve2 = Offset(size.width, size.height - 30);
    final firstCurve2 = Offset(size.width, size.height);
    path.quadraticBezierTo(
        lastCurve2.dx, lastCurve2.dy, firstCurve2.dx, firstCurve2.dy);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Return true if the new instance needs to repaint the path
  }
}