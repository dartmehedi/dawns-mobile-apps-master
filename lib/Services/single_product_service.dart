import 'package:flutter/cupertino.dart';

class SingleProductService with ChangeNotifier {
  int _count = 1;

  getCount() => _count;
  // setCount(int count) => _count = count;
  resetCount() {
    _count = 1;
    notifyListeners();
  }

  incraseCount() {
    _count++;
    notifyListeners();
  }

  decreaseCount() {
    if (_count != 1) {
      _count--;
      notifyListeners();
    }
  }
}
