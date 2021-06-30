import 'dart:convert';

import 'package:campsite_fms_app_user/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryDeviceGetX extends GetxController {
  final token = FlutterSecureStorage();
  var selectedCategoryId;
  var selectedCampId;
  List ciList = new List();
  List cnList = new List();
  Map<String, int> cMap = new Map();
  Map<String, int> campIndex = new Map();
  var categoryList;
  var detailData;

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

  setSelectedCampId(campId) {
    this.selectedCampId = campId;
    print('campId: ' + selectedCampId.toString());
  }

  setCMap(index, name) {
    this.cMap[name] = index;
  }

  setCampIndex(index, name) {
    this.campIndex[name] = index;
  }

  setData(data) {
    this.detailData = data;
    update();
  }

  @override
  onInit() {
    super.onInit();
  }

  apiDetailData() async {
    var url = Env.url +
        '/api/reservation/user/detail/list?campsite_id=' +
        selectedCampId.toString();
    // String value = await token.read(key: 'token');
    // String myToken = ("Bearer " + value);

    await setData(jsonDecode(utf8.decode((await http.get(url)).bodyBytes)));

    cMap.clear();
    for (var i = 0; i < detailData.length; i++) {
      setCMap(detailData[i]['id'], detailData[i]['name']);
    }

    print(detailData);
    print(detailData[0]);
    update();
  }
}
