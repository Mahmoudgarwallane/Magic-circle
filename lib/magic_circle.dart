import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class MagicCircle extends StatefulWidget {
  final Function(String angle, String cos, String sin) onDrag;
  const MagicCircle({Key? key, required this.onDrag}) : super(key: key);

  @override
  State<MagicCircle> createState() => _MagicCircleState();
}

class _MagicCircleState extends State<MagicCircle> {
  double angle = 0;
  void onPanUpdate(DragUpdateDetails details) {
    Offset coordinates = details.localPosition;
    setState(() {
      var center = (min(MediaQuery.of(context).size.height,
                  MediaQuery.of(context).size.width) -
              40) /
          2;
      Offset pureCoordinates = Offset(((coordinates.dx - center) / center),
          ((coordinates.dy - center) / center) * -1);
      var angleTan = (pureCoordinates.dy.abs()) / (pureCoordinates.dx.abs());
      angle = atan(angleTan) * 180 / pi;
      (pureCoordinates.toString());
      if (pureCoordinates.dx.isNegative && !pureCoordinates.dy.isNegative) {
        angle = 90 - angle;
        angle += 90;
      }
      if (pureCoordinates.dx.isNegative && pureCoordinates.dy.isNegative) {
        angle += 180;
      }
      if (!pureCoordinates.dx.isNegative && pureCoordinates.dy.isNegative) {
        angle = 90 - angle;
        angle += 270;
      }

      widget.onDrag(
          angle.toStringAsFixed(2),
          pureCoordinates.dx.toStringAsFixed(2),
          pureCoordinates.dy.toStringAsFixed(2));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: min(height, width) - 40,
      height: min(height, width) - 40,
      child: GestureDetector(
        onPanUpdate: onPanUpdate,
        child: CustomPaint(
          painter: Circle(angle),
        ),
      ),
    );
  }
}

class Circle extends CustomPainter {
  final double angle;
  Circle(this.angle);
  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(0, 0);
    canvas.translate(size.width / 2, size.height / 2);
    var radius = size.width / 2;
    var circleBrush = Paint()..color = Color(0xff4FBDBA);
    var handlerBrush = Paint()..color = Colors.red;
    var innerHandlerBrush = Paint()..color = Color(0xffAEFEFF);
    var linesBrush = Paint()
      ..color = Color(0xff000000)
      ..strokeWidth = 3;
    var coorBrush = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 3;
    canvas.drawCircle(center, radius, circleBrush);
    canvas.drawLine(center, Offset(center.dx, center.dy + radius), linesBrush);
    canvas.drawLine(center, Offset(center.dx, center.dy + -radius), linesBrush);
    canvas.drawLine(center, Offset(center.dx + radius, center.dy), linesBrush);
    canvas.drawLine(center, Offset(center.dx + -radius, center.dy), linesBrush);
    canvas.drawLine(center, Offset(center.dx + -radius, center.dy), linesBrush);

    canvas.drawLine(
        Offset((cos(-angle * pi / 180) * radius), 0),
        Offset((radius * cos(-angle * pi / 180)),
            (radius * sin(-angle * pi / 180))),
        coorBrush);
    canvas.drawLine(
        Offset(0, (sin(-angle * pi / 180) * radius)),
        Offset((radius * cos(-angle * pi / 180)),
            (radius * sin(-angle * pi / 180))),
        coorBrush);
    canvas.drawLine(
        center,
        Offset((radius * cos(-angle * pi / 180)),
            (radius * sin(-angle * pi / 180))),
        linesBrush);
    canvas.drawCircle(
        Offset((radius * cos(-angle * pi / 180)),
            (radius * sin(-angle * pi / 180))),
        11,
        handlerBrush);
    canvas.drawCircle(
        Offset(center.dx + (radius * cos(-angle * pi / 180)),
            center.dx + (radius * sin(-angle * pi / 180))),
        5,
        innerHandlerBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
