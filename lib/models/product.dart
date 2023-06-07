import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:halo_smoothie/models/category.dart';

List<ProductModel> modelProductFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

class ProductModel extends ChangeNotifier {
  int id;
  String name;
  double price;
  double salePrice;
  double calories;
  String descs;
  String img;
  CategoryModel category;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.salePrice,
    required this.calories,
    required this.descs,
    required this.img,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as double,
      salePrice: json['salePrice'] as double,
      calories: json['calories'] as double,
      descs: json['descs'] as String,
      img: json['img'] as String,
      category: CategoryModel.fromJson(
        json['category'],
      ),
    );
  }
}
