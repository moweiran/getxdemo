import 'package:flutter/material.dart';

/// 倒计时动画效果
///
/// 数字逐步放大缩小，渐入渐出
class CountDownAnimation extends StatefulWidget {
  /// 开始数值
  final int startNumber;

  /// 动画间隔时间
  final Duration? duration;

  /// 动画结束的回调
  final Function? completedCallback;
  CountDownAnimation({
    Key? key,
    required this.startNumber,
    required this.completedCallback,
    Duration? duration,
  })  : duration = duration ?? Duration(seconds: 1),
        super(key: key);

  @override
  State<CountDownAnimation> createState() => _CountDownAnimationState();
}

class _CountDownAnimationState extends State<CountDownAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  late int count;
  @override
  void initState() {
    super.initState();
    count = widget.startNumber;

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      // -- ----- -- -- ----- --
      // 200f 500s 200r 200f 500s 200r 200f 500s 200r
      for (var i = widget.startNumber; i > 0; i--) {
        if (mounted) {
          _animationController.forward();
        }
        await Future.delayed(const Duration(milliseconds: 700));
        if (mounted) {
          _animationController.reverse();
        }
        await Future.delayed(const Duration(milliseconds: 200));
        if (mounted) {
          setState(() {
            count--;
          });
        }
      }
      if (mounted) {
        widget.completedCallback?.call();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animationController, //设置动画的缩放中心
      alignment: Alignment.center,
      child: FadeTransition(
        opacity: _animationController,
        child: Text(
          '$count',
          style: const TextStyle(
            fontSize: 130,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: 'Seravek',
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
