import 'package:flutter/material.dart';

class TotalPriceProvider extends ChangeNotifier {
  var totalPrice = 0.0;

  void updatePriceAfterUseCoupon(double newPrice) {
    this.totalPrice = newPrice;
    notifyListeners();
  }

  void updateTotalPrice(double newPrice) {
    this.totalPrice = newPrice;
    notifyListeners();
  }
}
