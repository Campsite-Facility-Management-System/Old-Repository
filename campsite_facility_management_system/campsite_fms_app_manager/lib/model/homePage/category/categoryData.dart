import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryData {
  var index;
  var name;
  var price;
  var description;
  var img_url;

  CategoryData(
      this.index, this.name, this.price, this.description, this.img_url);

  factory CategoryData.fromJson(dynamic json) {
    return CategoryData(
      json['index'] as int,
      json['name'] as String,
      json['price'] as String,
      json['description'] as String,
      json['img_url'] as String,
    );
  }
}
