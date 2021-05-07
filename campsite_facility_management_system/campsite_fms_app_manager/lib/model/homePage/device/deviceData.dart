import 'package:flutter/material.dart';

class DeviceData {
  var id;
  var campsite_id;
  var site_type_id;
  var uuid;
  var name;
  var state;
  var created_at;
  var updated_at;

  DeviceData(
    this.id,
    this.campsite_id,
    this.site_type_id,
    this.uuid,
    this.name,
    this.state,
    this.created_at,
    this.updated_at,
  );

  factory DeviceData.fromJson(dynamic json) {
    return DeviceData(
      json['id'] as int,
      json['campsite_id'] as int,
      json['site_type_id'] as int,
      json['uuid'] as String,
      json['name'] as String,
      json['state'] as int,
      json['created_at'] as String,
      json['updated_at'] as String,
    );
  }
}
