import 'package:flutter/foundation.dart';

class GlobalState with ChangeNotifier {
  bool _isSomeCondition = false;

  bool get isSomeCondition => _isSomeCondition;

  void setSomeCondition(bool value) {
    _isSomeCondition = value;
    notifyListeners();
  }
}
