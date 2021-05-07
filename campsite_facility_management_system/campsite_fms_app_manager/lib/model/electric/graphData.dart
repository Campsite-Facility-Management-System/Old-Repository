import 'package:flutter/material.dart';

class GraphData {
  var max;
  var electricity;

  GraphData(this.max, this.electricity);

  factory GraphData.fromJson(dynamic json) {
    return GraphData(
      json['max'] as int,
      json['electricity'] as Map<String, String>,
    );
  }
}
