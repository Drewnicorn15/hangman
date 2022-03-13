import 'package:flutter/material.dart';

class Paintstart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.white;
    canvas.drawLine(Offset(size.width * 1 / 8, size.height * 1 / 8),
        Offset(size.width * 1 / 8, size.height * 7 / 8), paint);
    canvas.drawLine(Offset(size.width * 1 / 2, size.height * 1 / 8),
        Offset((size.width * 1 / 8) - 5, size.height * 1 / 8), paint);
    canvas.drawLine(Offset(size.width * 1 / 2, (size.height * 1 / 8) - 5),
        Offset((size.width * 1 / 2), size.height * 1 / 4), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Paintpt2 extends CustomPainter {
  Paintstart prevous = Paintstart();
  @override
  void paint(Canvas canvas, Size size) {
    prevous.paint(canvas, size);
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset((size.width * 1 / 2), (size.height * 1 / 4) + 20), 20, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Paintpt3 extends CustomPainter {
  Paintpt2 prevous = Paintpt2();
  @override
  void paint(Canvas canvas, Size size) {
    prevous.paint(canvas, size);
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width * 1 / 2, (size.height * 1 / 4) + 40),
        Offset(size.width * 1 / 2, (size.height * 1 / 2) + 40), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Paintpt4 extends CustomPainter {
  Paintpt3 prevous = Paintpt3();
  @override
  void paint(Canvas canvas, Size size) {
    prevous.paint(canvas, size);
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width * 1 / 2, (size.height * 1 / 2.5) + 40),
        Offset(size.width * 1 / 3, (size.height * 1 / 3) + 40), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Paintpt5 extends CustomPainter {
  Paintpt4 prevous = Paintpt4();
  @override
  void paint(Canvas canvas, Size size) {
    prevous.paint(canvas, size);
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width * 1 / 2, (size.height * 1 / 2.5) + 40),
        Offset(size.width * 2 / 3, (size.height * 1 / 3) + 40), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Paintpt6 extends CustomPainter {
  Paintpt5 prevous = Paintpt5();
  @override
  void paint(Canvas canvas, Size size) {
    prevous.paint(canvas, size);
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width * 1 / 2, (size.height * 1 / 2.5) + 65),
        Offset(size.width * 2 / 3, (size.height * 2 / 3) + 25), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Paintpt7 extends CustomPainter {
  Paintpt6 prevous = Paintpt6();
  @override
  void paint(Canvas canvas, Size size) {
    prevous.paint(canvas, size);
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width * 1 / 2, (size.height * 1 / 2.5) + 65),
        Offset(size.width * 1 / 3, (size.height * 2 / 3) + 25), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Paintblank extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.white;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
