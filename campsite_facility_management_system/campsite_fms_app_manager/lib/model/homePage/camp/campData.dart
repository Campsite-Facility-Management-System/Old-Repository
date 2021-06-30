import 'package:campsite_fms_app_manager/function/addPicture.dart';
import 'package:flutter/material.dart';

class CampData {
  var id;
  var owner_id;
  var name;
  var telephone;
  var address;
  var description;
  var img_url;

  CampData(this.id, this.owner_id, this.name, this.telephone, this.address,
      this.description, this.img_url);

  factory CampData.fromJson(dynamic json) {
    return CampData(
        json['id'] as int,
        json['owner_id'] as String,
        json['name'] as String,
        json['telephone'] as String,
        json['address'] as String,
        json['description'] as String,
        json['img_url'] as String);
  }
}
