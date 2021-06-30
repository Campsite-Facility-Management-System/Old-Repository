import 'dart:convert';

import 'package:campsite_fms_app_user/env.dart';
// import 'package:campsite_fms_app_user/provider/idCollector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

class CampDetailGetX extends GetxController {
  final token = FlutterSecureStorage();
  var selectedCategoryId;
  var selectedCampId;
  List ciList = new List();
  List cnList = new List();
  Map<String, int> cMap = new Map();
  Map<String, int> campIndex = new Map();
  var campDetailData;

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

  setSelectedCampId(id) {
    this.selectedCampId = id;
  }

  setCampDetailData(data) {
    this.campDetailData = data;
    update();
  }

  getData() async {
    var url = Env.url +
        '/api/reservation/user/campsite/info?campsite_id=' +
        selectedCampId.toString();
    // String value = await token.read(key: 'token');
    // String myToken = ("Bearer " + value);

    // var response = await http.get(url);

    // , headers: {
    //   'Authorization': myToken,
    // }, body: {
    //   'campsite_id': selectedCampId.toString(),
    // }
    // );

    await setCampDetailData(
        jsonDecode(utf8.decode((await http.get(url)).bodyBytes)));

    print(campDetailData);
    print(campDetailData['img_url'][0]['img_url']);

    // for (var i = 0; i < categoryList.length; i++) {
    //   setCMap(categoryList[i]['id'], categoryList[i]['name']);
    // }
  }

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//   }
}
