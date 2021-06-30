import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryData {
  var index;
  var name;
  var price;
  var description;
  var max_car_num;
  var max_adult_num;
  var max_children_num;
  var max_energy;
  var img_url;

  CategoryData(
      this.index,
      this.name,
      this.price,
      this.description,
      this.max_car_num,
      this.max_adult_num,
      this.max_children_num,
      this.max_energy,
      this.img_url);

  factory CategoryData.fromJson(dynamic json) {
    return CategoryData(
      json['index'] as int,
      json['name'] as String,
      json['price'] as String,
      json['description'] as String,
      json['img_url'] as String,
      json['max_car_num'] as int,
      json['max_adult_num'] as int,
      json['max_children_num'] as int,
      json['max_energy'] as int,
    );
  }
}
