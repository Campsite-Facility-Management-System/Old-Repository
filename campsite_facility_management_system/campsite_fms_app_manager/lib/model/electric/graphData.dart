import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphData extends ChangeNotifier {
  var max = 0;
  var electricity;

  GraphData(this.max, this.electricity);

  factory GraphData.fromJson(dynamic json) {
    return GraphData(json['max'] as int, json['electricity'] as List<FlSpot>);
  }

  setMax(max) {
    this.max = max;
    notifyListeners();
  }

  setElectricity(electricity) {
    this.electricity = electricity;
    notifyListeners();
  }
}
