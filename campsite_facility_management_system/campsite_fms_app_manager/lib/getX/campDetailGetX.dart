import 'dart:convert';

import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CampDetailGetX extends GetxController {
  final token = FlutterSecureStorage();
  var selectedCategoryId;
  var selectedCampId;
  List ciList = new List();
  List cnList = new List();
  Map<String, int> cMap = new Map();
  Map<String, int> campIndex = new Map();
  var categoryList;

  setCategoryId(id) {
    this.selectedCategoryId = id;
  }

  setCampId(id) {
    this.selectedCampId = id;
  }

  setCIList(list) {
    this.ciList = list;
  }

  setCNList(list) {
    this.cnList = list;
  }

  setCMap(index, name) {
    this.cMap[name] = index;
  }

  setCampIndex(index, name) {
    this.campIndex[name] = index;
  }

  getData() async {
    var url = Env.url + '/api/category/manager/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'campsite_id': selectedCampId.toString(),
    });

    categoryList = jsonDecode(utf8.decode(response.bodyBytes));

    for (var i = 0; i < categoryList.length; i++) {
      setCMap(categoryList[i]['id'], categoryList[i]['name']);
    }
  }
}
