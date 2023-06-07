class MaterialModel {
  int id;
  String name;
  double price;

  double calories;
  String img;
  String color;
  String descs;
  int status;

  MaterialModel({
    required this.id,
    required this.name,
    required this.price,
    required this.calories,
    required this.img,
    required this.color,
    required this.descs,
    required this.status,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as double,
      calories: json['calories'] as double,
      img: json['img'] as String,
      color: json['color'] as String,
      descs: json['descs'] as String,
      status: json['status'] as int,
    );
  }
}
