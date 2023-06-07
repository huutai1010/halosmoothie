import 'package:flutter/material.dart';

class TokenModel extends ChangeNotifier {
  String accessToken;
  TokenModel({required this.accessToken});

  factory TokenModel.fromJson(dynamic json) {
    return TokenModel(accessToken: json['accessToken'] as String);
  }

  void updateAccessToken(String accessToken) {
    this.accessToken = accessToken;
    notifyListeners();
  }
}
