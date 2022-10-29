import 'package:flutter/material.dart';

import 'slider_info.dart';
import 'slider_notifier.dart';
import 'spinner.dart';

class InheritedNotifierDemoPage extends StatefulWidget {
  final SliderInfo sliderInfo;
  const InheritedNotifierDemoPage({
    Key? key,
    required this.sliderInfo,
  }) : super(key: key);

  @override
  _InheritedNotifierDemoPageState createState() =>
      _InheritedNotifierDemoPageState();
}

class _InheritedNotifierDemoPageState extends State<InheritedNotifierDemoPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('InheritedNotifierDemoPage')),
      body: SliderNotifier(
        notifier: widget.sliderInfo,
        child: Builder(builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              Slider(
                min: 0.0,
                max: 1.0,
                value: SliderNotifier.of(context),
                onChanged: (double value) {
                  widget.sliderInfo.value = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const <Widget>[
                  Spinner(),
                  Spinner(),
                  Spinner(),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
