import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/coupon.dart';

class ListCoupon extends ChangeNotifier {
  int statusCode;
  String message;
  List<Coupon> data = [];
  ListCoupon({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ListCoupon.fromJSON(Map<String, dynamic> json) {
    final couponsData = json['data'] as List<dynamic>?;
    final coupons = couponsData != null
        ? couponsData.map((couponData) => Coupon.fromJson(couponData)).toList()
        : <Coupon>[];
    return ListCoupon(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: coupons,
    );
  }
}
