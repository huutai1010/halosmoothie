import 'dart:convert';

import 'package:flutter/material.dart';

List<OfficeModel> modelOfficeFromJson(String str) =>
    List<OfficeModel>.from(jsonDecode(str).map((x) => OfficeModel.fromJson(x)));

class OfficeModel extends ChangeNotifier {
  int id;
  String name;
  String address;
  String phone;
  String img;
  int status;

  OfficeModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.img,
    required this.status,
  });

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      img: json['img'] as String,
      status: json['status'] as int,
    );
  }

  void changeOfficeData(int id, String name, String address, String phone,
      String img, int status) {
    this.id = id;
    this.name = name;
    this.address = address;
    this.phone = phone;
    this.img = img;
    this.status = status;
    notifyListeners();
  }

  void resetOfficeProvider() {
    this.id = 0;
    this.name = '';
    this.address = '';
    this.phone = '';
    this.img = '';
    this.status = 0;
    notifyListeners();
  }
}
