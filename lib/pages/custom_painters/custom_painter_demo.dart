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
      body: Container(
        width: 100,
        height: 100,
        child: Text('CustomPainterDemo'),
      ),
    );
  }
}
