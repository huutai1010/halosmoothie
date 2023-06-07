import 'package:flutter/material.dart';

class ProfileRes extends ChangeNotifier {
  int statusCode;
  String message;
  Profile data;

  ProfileRes({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ProfileRes.fromJson(Map<String, dynamic> json) {
    return ProfileRes(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: Profile.fromJson(
        json['data'],
      ),
    );
  }

  void resetProfile() {
    this.statusCode = 0;
    this.message = '';
    this.data = Profile(
        id: '', firstName: '', lastName: '', email: '', status: 0, image: '');
  }

  void updateProfile(int statusCode, String message, Profile data) {
    this.statusCode = statusCode;
    this.message = message;
    this.data = data;
  }
}

class Profile {
  String id;
  String firstName;
  String lastName;
  String email;
  String? dateOfBirth;
  String? phone;
  int status;
  String? address;
  String? role;
  String image;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    String? dateOfBirth,
    String? phone,
    required this.status,
    String? address,
    String? role,
    required this.image,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      status: json['status'] as int,
      image: json['image'] as String,
    );
  }
}
