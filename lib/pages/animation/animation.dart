import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class AnimationDemoPage extends StatefulWidget {
  const AnimationDemoPage({Key? key}) : super(key: key);

  @override
  State<AnimationDemoPage> createState() => _AnimationDemoPageState();
}

class _AnimationDemoPageState extends State<AnimationDemoPage> {
  double height = 100;
  double width = 100;
  int value = 0;
  double opacity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('animotion'),
      ),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          // height: height,
          // width: width,
          // decoration: const BoxDecoration(
          //   color: Colors.blue,
          //   borderRadius: BorderRadius.all(Radius.circular(15)),
          // ),
          opacity: opacity,
          curve: Curves.bounceInOut,
          child: Center(
            child: Text(
              'Hi,$value',
              style: const TextStyle(fontSize: 100),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('ccc'),
        onPressed: () {
          //
          // height += 10;
          // width += 10;
          // if (height > 100) {
          //   height = 10;
          //   width = 10;
          // }
          // value++;
          Timer.periodic(const Duration(seconds: 1), (timer) {
            print(timer.tick);
            value += 1;
            opacity = NumUtil.add(opacity, 0.1);
            if (opacity == 1) {
              opacity = 0;
            }
            if (value == 10) {
              // timer.cancel();
              value = 0;
            }
            print(value);
            print(opacity);
            setState(() {});
          });
        },
      ),
    );
  }
}
