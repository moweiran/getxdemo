import 'package:flutter/foundation.dart';

class MainStoreProvider with ChangeNotifier {
  int _count = 0;
  int _secondCount = 0;

  int get count => _count;

  incrementCounter() {
    _count++;
    notifyListeners();
  }

  int get secondCount => _secondCount;

  incrementSecondCounter() {
    _secondCount++;
    notifyListeners();
  }
}
