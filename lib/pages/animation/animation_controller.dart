import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class AnimationControllerDemo extends StatefulWidget {
  const AnimationControllerDemo({Key? key}) : super(key: key);

  @override
  State<AnimationControllerDemo> createState() =>
      _AnimationControllerDemoState();
}

class _AnimationControllerDemoState extends State<AnimationControllerDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late int countDown = 3;
  late double opacityLevel = 0;
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    // _animationController.addListener(() {
    //   print(_animationController.value);
    // });
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        print("status is completed");
        Future.delayed(const Duration(milliseconds: 500), () {
          _animationController.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
        print("status is dismissed");
        setState(() {
          countDown--;
        });
        if (countDown <= 0) {
          _animationController.stop();
          toast('ok');
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.forward) {
        print("status is forward");
        //执行 controller.forward() 会回调此状态
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
        print("status is reverse");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
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
            child: ScaleTransition(
              scale: _animationController, //设置动画的缩放中心
              alignment: Alignment.center,
              child: FadeTransition(
                opacity: _animationController,
                child: Text(
                  '$countDown',
                  style: const TextStyle(
                    fontSize: 130,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Seravek',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TickerFuture tickerFuture = _animationController.forward();
          // 3秒后结束
          tickerFuture.timeout(const Duration(seconds: 3), onTimeout: () {
            // _animationController.forward(from: 0);
            _animationController.stop(canceled: true);
          });
        },
        child: const Text('+'),
      ),
    );
  }
}
