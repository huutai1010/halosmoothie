import 'package:flutter/material.dart';
import 'package:halo_smoothie/models/office.dart';

class ListOfficesProvider extends ChangeNotifier {
  List<OfficeModel> listOffice = [];

  void updateListOffice(List<OfficeModel> newListOffices) {
    listOffice = [];
    for (var office in newListOffices) {
      listOffice.add(office);
    }
    notifyListeners();
  }
}
