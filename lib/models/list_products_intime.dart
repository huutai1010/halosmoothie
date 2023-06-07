import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/office.dart';
import 'package:halo_smoothie/models/product.dart';

class ListProductsInTime extends ChangeNotifier {
  int id;
  String name;
  String startTime;
  String endTime;
  List<ProductModel> products = [];
  OfficeModel office;

  ListProductsInTime({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.products,
    required this.office,
  });

  factory ListProductsInTime.fromJSON(Map<String, dynamic> json) {
    final productsData = json['products'] as List<dynamic>?;
    // if the reviews are not missing
    final products = productsData != null
        // map each review to a Review object
        ? productsData
            .map((productData) => ProductModel.fromJson(productData))
            // map() returns an Iterable so we convert it to a List
            .toList()
        // use an empty list as fallback value
        : <ProductModel>[];
    return ListProductsInTime(
      id: json['id'] as int,
      name: json['name'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      products: products,
      office: OfficeModel.fromJson(
        json['office'],
      ),
    );
  }

  void updateListProducts(int id, List<ProductModel> newListProducts) {
    this.id = id;
    products = [];
    for (var product in newListProducts) {
      products.add(product);
    }
    notifyListeners();
  }

  void updateListProductsInTime(
      int id,
      String name,
      String startTime,
      String endTime,
      List<ProductModel> newListProducts,
      OfficeModel officeModel) {
    this.id = id;
    this.name = name;
    this.startTime = startTime;
    this.endTime = endTime;
    this.office = officeModel;
    products = [];
    for (var product in newListProducts) {
      products.add(product);
    }
    notifyListeners();
  }
}
