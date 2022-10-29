import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/pages/inherited_notifier/spinner.dart';

import 'inherited_notifier_demo.dart';
import 'slider_info.dart';
import 'slider_notifier.dart';

class InheritedNotifierSecondPage extends StatefulWidget {
  final SliderInfo sliderInfo;
  const InheritedNotifierSecondPage({
    Key? key,
    required this.sliderInfo,
  }) : super(key: key);

  @override
  State<InheritedNotifierSecondPage> createState() =>
      _InheritedNotifierSecondPageState();
}

class _InheritedNotifierSecondPageState
    extends State<InheritedNotifierSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedNotifierSecondPage'),
        actions: [
          IconButton(
            onPressed: () => Get.to(
                () => InheritedNotifierDemoPage(sliderInfo: widget.sliderInfo)),
            icon: const Icon(Icons.favorite),
          )
        ],
      ),
      body: SliderNotifier(
        notifier: widget.sliderInfo,
        child: const Spinner(),
      ),
    );
  }
}
