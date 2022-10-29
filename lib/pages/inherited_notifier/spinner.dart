import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'slider_notifier.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(SliderNotifier.of(context));
    return Transform.rotate(
      angle: SliderNotifier.of(context) * 2.0 * math.pi,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.green,
        child: const Center(
          child: Text('Whee!'),
        ),
      ),
    );
  }
}
