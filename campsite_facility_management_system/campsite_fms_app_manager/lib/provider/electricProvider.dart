import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ElectricProvider extends ChangeNotifier {
  var selectedCampId;

  setCampId(campId) {
    this.selectedCampId = campId;
    print("setCampId: " + selectedCampId);
    notifyListeners();
  }

  refreshButton() {
    notifyListeners();
  }
}
