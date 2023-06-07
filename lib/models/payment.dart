class Payment {
  int id;
  String createTime;
  String paymentTime;
  String content;
  int paymentTypeId;

  Payment({
    required this.id,
    required this.createTime,
    required this.paymentTime,
    required this.content,
    required this.paymentTypeId,
  });
}
