import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CircularProgressBar extends StatelessWidget {
  final double progress; // the progress percentage (0-1)
  final double radius; // the size of the circular container
  final Color color; // the main color of the circular container
  final double strokeWidth;

  const CircularProgressBar(
      {Key? key,
      required this.progress,
      required this.radius,
      required this.color,
      required this.strokeWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // the width of the progress indicator line

    return Center(
      child: SizedBox(
        width: radius * 2.1,
        height: radius * 2.1,
        child: CustomPaint(
          painter: _ProgressPainter(
            progress: progress,
            strokeWidth: strokeWidth,
            color: color,
            radius: radius,
          ),
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;
  final double radius;

  _ProgressPainter(
      {required this.progress,
      required this.strokeWidth,
      required this.color,
      required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    const double defaultProgressAngle = 2 * pi;
    final double finishedProgressAngle = 2 * pi * progress;
    final Paint defaultPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final Paint finishedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Draw the default progress arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      -pi / 2.0,
      defaultProgressAngle,
      false,
      defaultPaint,
    );

    // Draw the finished progress arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      -pi / 2.0,
      finishedProgressAngle,
      false,
      finishedPaint,
    );
  }

  @override
  bool shouldRepaint(_ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
