import 'package:campsite_fms_app_manager/function/addPicture.dart';
import 'package:flutter/material.dart';

class ElectricData {
  var id;
  var name;
  var uuid;
  var switchStatus;
  var usage;
  var charge;

  ElectricData(this.id, this.name, this.uuid, this.switchStatus, this.usage,
      this.charge);

  factory ElectricData.fromJson(dynamic json) {
    return ElectricData(
      json['id'] as int,
      json['name'] as String,
      json['uuid'] as String,
      json['switchStatus'] as String,
      json['usage'] as String,
      json['charge'] as String,
    );
  }
}
