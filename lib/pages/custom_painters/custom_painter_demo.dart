import 'package:flutter/material.dart';

class CustomPainterDemo extends StatefulWidget {
  const CustomPainterDemo({Key? key}) : super(key: key);

  @override
  State<CustomPainterDemo> createState() => _CustomPainterDeomState();
}

class _CustomPainterDeomState extends State<CustomPainterDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomGuidePainter'),
        elevation: 0,
      ),
      body: Center(
        child: CustomPaint(
          painter: GuidePainter(),
          child: const SizedBox(
            width: 200,
            height: 200,
            // color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class GuidePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint gradientPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x90AD00FF),
          Color(0xFF701AC6),
        ],
      ).createShader(const Rect.fromLTWH(0, 0, 200, 200));
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path = Path();
    // 三角
    // _path
    //   ..moveTo(0, size.height)
    //   ..lineTo(size.width / 2, 0)
    //   ..lineTo(size.width, size.height)
    //   ..lineTo(0, size.height);

    // path
    //   ..moveTo(0, size.height)
    //   ..lineTo(size.width / 2, 0)
    //   ..lineTo(size.width, size.height)
    //   ..lineTo(0, size.height);

    // path.lineTo(0, size.height * 0.3);

    /// Adds a quadratic bezier segment that curves from the current
    /// point to the given point (x2,y2), using the control point
    /// (x1,y1) 二阶贝塞尔曲线,控制点为(x1,y1),终点为(x2,y2),起点为当前path所在的点
    // void quadraticBezierTo(double x1, double y1, double x2, double y2) native 'Path_quadraticBezierTo';

    /// Adds a cubic bezier segment that curves from the current point
    /// to the given point (x3,y3), using the control points (x1,y1) and
    /// (x2,y2) 三阶贝塞尔曲线,控制点为(x1,y1),(x2,y2),终点为(x3,y3),起点为当前path所在的点
    // void cubicTo(double x1, double y1, double x2, double y2, double x3, double y3) native 'Path_cubicTo';

    // path.quadraticBezierTo(size.width * 0.35, size.height * 0.4,
    //     size.width * 0.7, size.height * 0.21);
    // path.quadraticBezierTo(size.width * 0.6, size.height * 0.19,
    //     size.width * 0.9, size.height * 0.15);
    // path.quadraticBezierTo(size.width, size.height * 0.05, size.width * 0.6, 0);

    double raidus = 20;
    path.moveTo(0, 50);
    path.cubicTo(0, 50, 0, 30, raidus, 30);

    path.lineTo(size.width / 2 - 30, 30);
    path.cubicTo(
        size.width / 2 - 30, 30, size.width / 2, 30, size.width / 2, 15);

    Rect rect = Rect.fromPoints(
        Offset(size.width / 2 - 30, 0), Offset(size.width / 2 + 30, 80));
    path.addOval(rect);

    // path.quadraticBezierTo(
    //     size.width * 0.5, size.height * 0.4, size.width, size.height - 10);

    canvas.drawRect(const Rect.fromLTWH(0, 0, 200, 200), gradientPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
