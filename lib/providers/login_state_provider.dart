import 'package:flutter/material.dart';

class LoginStateProvider extends ChangeNotifier {
  var loginState = false;
  changeLoginState(bool newLoginState) {
    this.loginState = newLoginState;
    notifyListeners();
  }
}
