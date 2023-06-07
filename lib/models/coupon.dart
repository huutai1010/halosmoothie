class Coupon {
  int id;
  String code;
  String exp;
  int discount;
  int status;

  Coupon({
    required this.id,
    required this.code,
    required this.exp,
    required this.discount,
    required this.status,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      code: json['code'],
      exp: json['exp'],
      discount: json['discount'],
      status: json['status'],
    );
  }
}
