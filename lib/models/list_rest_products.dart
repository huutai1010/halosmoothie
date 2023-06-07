import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/product.dart';

class ListRestProduct extends ChangeNotifier {
  int statusCode;
  String message;
  List<ProductModel> data;

  ListRestProduct({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ListRestProduct.fromJSON(Map<String, dynamic> json) {
    final productsData = json['data'] as List<dynamic>?;
    // if the reviews are not missing
    final products = productsData != null
        // map each review to a Review object
        ? productsData
            .map((productData) => ProductModel.fromJson(productData))
            // map() returns an Iterable so we convert it to a List
            .toList()
        // use an empty list as fallback value
        : <ProductModel>[];
    return ListRestProduct(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: products,
    );
  }

  void updateListRestOfProducts(
      int statusCode, String message, List<ProductModel> newData) {
    this.statusCode = statusCode;
    this.message = message;
    data = [];
    for (var product in newData) {
      data.add(product);
    }
    notifyListeners();
  }
}
