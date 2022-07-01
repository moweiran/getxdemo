import 'package:flutter/foundation.dart';

class SliderInfo extends ChangeNotifier {
  SliderInfo();

  double get value => _value;
  double _value = 0.0;
  set value(double value) {
    if (value != _value) {
      _value = value;
      notifyListeners();
    }
  }
}
