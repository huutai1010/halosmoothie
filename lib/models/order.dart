import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/payment.dart';

class Order extends ChangeNotifier {
  String customerId;
  int officeId;
  int? couponId;
  String dateOrder;
  String comment;
  int total;
  Payment payment;

  Order({
    required this.customerId,
    required this.officeId,
    required this.couponId,
    required this.dateOrder,
    required this.comment,
    required this.total,
    required this.payment,
  });
}
