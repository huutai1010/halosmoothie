import 'package:flutter/material.dart';

class OrderDetail extends ChangeNotifier {
  int productId;
  String name;
  String img = '';
  int quantity;
  String note = '';
  double price;
  double salePrice;
  List<Map<String, dynamic>> orderDetailMaterials;
  OrderDetail({
    required this.productId,
    required this.name,
    this.price = 0.0,
    this.salePrice = 0.0,
    required this.img,
    required this.quantity,
    required this.note,
    required this.orderDetailMaterials,
  });

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      "productId": this.productId,
      "quantity": this.quantity,
      "note": this.note,
      "orderDetailMaterials": this.orderDetailMaterials,
    } as Map<String, dynamic>;
  }

  void changeQuantity(int newQuantity) {
    this.quantity += newQuantity;
    notifyListeners();
  }
}
