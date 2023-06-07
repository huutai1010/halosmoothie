class OrderDetailMaterial {
  int materialId;
  double price;
  int quantity;
  String note = '';
  String color;
  String img;
  String name;
  OrderDetailMaterial({
    required this.materialId,
    this.price = 0,
    required this.quantity,
    required this.note,
    required this.color,
    required this.img,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      "materialId": this.materialId,
      "price": this.price,
      "quantity": this.quantity,
      "note": this.note,
    };
  }

  void changeQuantity(int quantity) {
    this.quantity += quantity;
  }
}
