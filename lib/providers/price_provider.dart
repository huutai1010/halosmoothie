import 'package:flutter/material.dart';

class PriceProvider extends ChangeNotifier {
  double priceAfterUseCoupon = 0.0;

  void changePrice(double newPrice) {
    priceAfterUseCoupon = newPrice;
    notifyListeners();
  }
}
