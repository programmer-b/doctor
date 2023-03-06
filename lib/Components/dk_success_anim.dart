import 'dart:ui';

import 'package:flutter/material.dart';

class DkSuccessAnim extends StatefulWidget {
  const DkSuccessAnim({super.key});

  @override
  SuccessCheckAnimationState createState() => SuccessCheckAnimationState();
}

class SuccessCheckAnimationState extends State<DkSuccessAnim> with SingleTickerProviderStateMixin {
 late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: SuccessCheckPainter(_controller.value),
          size: const Size(50, 50),
        );
      },
    );
  }
}


class SuccessCheckPainter extends CustomPainter {
  final double value;

  SuccessCheckPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    double width = size.width;
    double height = size.height;
    double radius = width / 2;

    Path path = Path()
      ..moveTo(radius / 2, height / 2)
      ..lineTo(radius, height / 2 + radius / 2)
      ..lineTo(width - radius / 4, radius / 4);

    Path checkPath = Path();
    PathMetrics pathMetrics = path.computeMetrics();
    double length = pathMetrics.length * value;
    for (PathMetric pathMetric in pathMetrics) {
      double end = length - pathMetric.length;
      if (end > 0) {
        checkPath.addPath(pathMetric.extractPath(0, pathMetric.length),
            Offset.zero);
        length = end;
      } else {
        checkPath.addPath(
            pathMetric.extractPath(pathMetric.length - length, pathMetric.length),
            Offset.zero);
        break;
      }
    }
    canvas.drawPath(checkPath, paint);
  }

  @override
  bool shouldRepaint(SuccessCheckPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
