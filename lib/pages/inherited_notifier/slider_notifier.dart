import 'package:flutter/material.dart';

import 'slider_info.dart';

class SliderNotifier extends InheritedNotifier<SliderInfo> {
  const SliderNotifier({
    Key? key,
    required SliderInfo notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static double of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SliderNotifier>()!
        .notifier!
        .value;
  }
}
