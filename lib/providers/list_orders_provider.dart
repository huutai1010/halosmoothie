import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/product_order_detail.dart';

class ListOrdersProvider extends ChangeNotifier {
  List<OrderDetail> orderDetails = [];
  ListOrdersProvider({required this.orderDetails});

  void updateListOrders(OrderDetail orderDetail) {
    orderDetails.add(orderDetail);
    notifyListeners();
  }

  void removeProduct(int index) {
    orderDetails.removeAt(index);
    notifyListeners();
  }

  void resetListOrders() {
    orderDetails = [];
    notifyListeners();
  }
}
