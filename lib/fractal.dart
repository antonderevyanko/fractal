import 'package:flutter/material.dart';
import 'dart:math' as math;

class Postman extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: FractalPainter(),
      );
}

class FractalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint triangleDotPaint = Paint()
      ..color = Colors.orange
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Paint dotPaint = Paint()
      ..color = Colors.deepPurple
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Paint linesPaint = Paint()
      ..color = Colors.orange
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final mainTriangleSize = 200;

    final pointAx = -math.Random().nextInt(mainTriangleSize).toDouble();
    final pointAy = -math.Random().nextInt(mainTriangleSize).toDouble();

    final pointBx = math.Random().nextInt(mainTriangleSize).toDouble();
    final pointBy = -math.Random().nextInt(mainTriangleSize).toDouble();

    final pointCx = 0.0;
    final pointCy = math.Random().nextInt(mainTriangleSize).toDouble();

    // draw base points
    canvas.drawCircle(Offset(pointAx, pointAy), 6.0, triangleDotPaint);
    canvas.drawCircle(Offset(pointBx, pointBy), 6.0, triangleDotPaint);
    canvas.drawCircle(Offset(pointCx, pointCy), 6.0, triangleDotPaint);
    // lines for the visual control
    canvas.drawLine(Offset(-100, 0), Offset(100, 0), linesPaint);
    canvas.drawLine(Offset(0, -100), Offset(0, 100), linesPaint);

    // we need first point to start
    final int pointX =
        mainTriangleSize - math.Random().nextInt(2 * mainTriangleSize);
    final int pointY =
        mainTriangleSize - math.Random().nextInt(2 * mainTriangleSize);
    Offset point = Offset(pointX.toDouble(), pointY.toDouble());
    canvas.drawCircle(point, 4.0, dotPaint);

    for (var i = 0; i < 2000; i++) {
      final pointToSeek = math.Random().nextInt(3);
      switch (pointToSeek) {
        case 0:
          point = moveToPoint(Offset(pointAx, pointAy), point);
          break;
        case 1:
          point = moveToPoint(Offset(pointBx, pointBy), point);
          break;
        case 2:
          point = moveToPoint(Offset(pointCx, pointCy), point);
          break;
        default:
      }
      canvas.drawCircle(point, 2.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Offset moveToPoint(Offset targetPoint, Offset stepPoint) {
  return Offset((targetPoint.dx + stepPoint.dx) / 2.0,
      (targetPoint.dy + stepPoint.dy) / 2.0);
}
