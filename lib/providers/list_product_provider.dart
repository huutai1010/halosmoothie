import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/product.dart';

class ListProductsProvider extends ChangeNotifier {
  List<ProductModel> listProducts = [];

  void updateListProducts(List<ProductModel> newListProducts) {
    listProducts = [];
    for (var product in newListProducts) {
      listProducts.add(product);
    }
    notifyListeners();
  }
}
