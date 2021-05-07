import 'package:campsite_fms_app_manager/function/addPicture.dart';
import 'package:flutter/material.dart';

class UsageData {
  var usage;
  var charge;

  UsageData(this.usage, this.charge);

  factory UsageData.fromJson(dynamic json) {
    return UsageData(
      json['usage'] as String,
      json['charge'] as String,
    );
  }
}
