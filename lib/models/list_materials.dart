import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/material.dart';

class ListMaterials extends ChangeNotifier {
  int statusCode;
  String message;
  List<MaterialModel> data = [];
  ListMaterials({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ListMaterials.fromJson(Map<String, dynamic> json) {
    final materialsData = json['data'] as List<dynamic>?;
    final materials = materialsData != null
        ? materialsData
            .map((materialData) => MaterialModel.fromJson(materialData))
            .toList()
        : <MaterialModel>[];
    return ListMaterials(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: materials,
    );
  }

  void updateListMaterials(
      int statusCode, String message, List<MaterialModel> newListMaterials) {
    this.statusCode = statusCode;
    this.message = message;
    data = [];
    for (var material in newListMaterials) {
      data.add(material);
    }
    notifyListeners();
  }
}
