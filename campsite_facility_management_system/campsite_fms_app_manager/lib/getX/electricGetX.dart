import 'package:campsite_fms_app_manager/env.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ElectricGetX extends GetxController {
  final token = new FlutterSecureStorage();
  List<String> campNameList = [];
  List<String> campIdList = [];
  var selectedCampId;
  var selectedCampName;
  var detailData;

  setSelectedCampId(campId) async {
    selectedCampId = campId;
    print("campId: " + selectedCampId);
    await apiElectricCategoryList();
  }

  setSelectedCampName(campName) {
    selectedCampName = campName;
    print("campName: " + selectedCampName);
  }

  apiCampInfo() async {
    var url = Env.url + '/api/campsite/manager/info';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    });

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // print(data.toString());

    for (var i = 0; i < data.length; i++) {
      campNameList.add(data[i]['name'].toString());
      campIdList.add(data[i]['id'].toString());
    }

    setSelectedCampId(campIdList[0]);
    setSelectedCampName(campNameList[0]);
  }

  apiElectricCategoryList() async {
    var url = Env.url + '/api/device/manager/energy/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'campsite_id': selectedCampId,
    });

    detailData = jsonDecode(utf8.decode(response.bodyBytes));

    // print('data: ' + detailData.toString());
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    apiCampInfo();
  }
}
