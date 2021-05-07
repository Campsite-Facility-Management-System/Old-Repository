import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IdCollector extends ChangeNotifier {
  var selectedCategoryId;
  var selectedCampId;
  List ciList = new List();
  List cnList = new List();
  Map<String, int> cMap = new Map();

  setCategoryId(id) {
    this.selectedCategoryId = id;
    notifyListeners();
  }

  setCampId(id) {
    this.selectedCampId = id;
    notifyListeners();
  }

  setCIList(list) {
    this.ciList = list;
    notifyListeners();
  }

  setCNList(list) {
    this.cnList = list;
    notifyListeners();
  }

  setCMap(index, name) {
    this.cMap[name] = index;
  }
}
