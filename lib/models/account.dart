import 'package:flutter/material.dart';

class AccountModel extends ChangeNotifier {
  String id;
  String firstName;
  String lastName;
  String email;
  String role;
  String image;

  AccountModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.image,
  });

  factory AccountModel.fromJson(dynamic json) {
    return AccountModel(
        id: json['id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        email: json['email'] as String,
        role: json['role'] as String,
        image: json['image'] as String);
  }

  void changeAccountInfo(String id, String firstName, String lastName,
      String email, String role, String image) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.role = role;
    this.image = image;
    notifyListeners();
  }
}
