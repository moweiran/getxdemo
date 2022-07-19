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
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          ClipPath(
            clipper: MessageClipper(borderRadius: 1),
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(1)),
                color: Colors.red,
              ),
              child: const Center(
                child: Text('MessageClipper'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// [MessageClipper], can be used with [ClipPath] widget, and clips the widget in dialog box shape
class MessageClipper extends CustomClipper<Path> {
  MessageClipper({this.borderRadius = 15});
  final double borderRadius;
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double rheight = height - height / 3;
    double oneThird = width / 3;

    final path = Path()
      ..lineTo(0, rheight - borderRadius)
      ..cubicTo(0, rheight - borderRadius, 0, rheight, borderRadius, rheight)
      ..lineTo(oneThird, rheight)
      ..lineTo(width / 2 - borderRadius, height - borderRadius)
      ..cubicTo(width / 2 - borderRadius, height - borderRadius, width / 2,
          height, width / 2 + borderRadius, height - borderRadius)
      ..lineTo(2 * oneThird, rheight)
      ..lineTo(width - borderRadius, rheight)
      ..cubicTo(width - borderRadius, rheight, width, rheight, width,
          rheight - borderRadius)
      ..lineTo(width, 0)
      ..lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
