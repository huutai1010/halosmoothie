import 'package:flutter/material.dart';

class StatusCodeProvider extends ChangeNotifier {
  int statusCode = 0;

  void updateStatusCode(int newStatusCode) {
    this.statusCode = newStatusCode;
    notifyListeners();
  }
}
