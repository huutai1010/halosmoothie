import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/order_detail_material.dart';

class ListOrderMaterials extends ChangeNotifier {
  List<OrderDetailMaterial> listOrderDetailMaterials = [];
  void updateListOrderMaterials(OrderDetailMaterial material) {
    listOrderDetailMaterials.add(material);
    notifyListeners();
  }

  void changeQuantityMaterial() {}
  void resetListOrderMaterials() {
    this.listOrderDetailMaterials = [];
    notifyListeners();
  }
}
