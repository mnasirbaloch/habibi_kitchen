import 'package:flutter/material.dart';

class PassVisibilityProvider with ChangeNotifier {
  bool _isPassVisible = false;
  bool get getPassVisibilityStatus => _isPassVisible;
  void togglePasswordVisibility() {
    _isPassVisible = !_isPassVisible;
    notifyListeners();
  }
}
