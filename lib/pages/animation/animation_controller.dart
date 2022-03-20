import 'package:flutter/material.dart';
import 'package:getxdemo/pages/animation/countdown_animation.dart';

class AnimationControllerDemo extends StatefulWidget {
  const AnimationControllerDemo({Key? key}) : super(key: key);

  @override
  State<AnimationControllerDemo> createState() =>
      _AnimationControllerDemoState();
}

class _AnimationControllerDemoState extends State<AnimationControllerDemo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimationControllerDemo'),
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
          height: 300,
          width: 300,
          child: Center(
            child: CountDownAnimation(
              startNumber: 3,
              duration: const Duration(milliseconds: 200),
              completedCallback: () {
                print('===stop===');
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
