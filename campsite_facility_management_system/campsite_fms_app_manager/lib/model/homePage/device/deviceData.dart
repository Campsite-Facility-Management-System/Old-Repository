import 'package:flutter/material.dart';

class DeviceData {
  var index;
  var uuid;
  var name;
  var category;

  DeviceData(this.index, this.uuid, this.name, this.category);

  factory DeviceData.fromJson(dynamic json) {
    return DeviceData(
      json['index'] as int,
      json['uuid'] as String,
      json['name'] as String,
      json['category'] as int,
    );
  }
}
