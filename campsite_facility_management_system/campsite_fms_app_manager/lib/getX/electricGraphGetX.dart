import 'dart:async';

import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ElectricGraphGetX extends GetxController {
  final token = new FlutterSecureStorage();
  final tokenFunction = new TokenFunction();
  Map graphData;
  List<FlSpot> spotList = List();
  List<int> leftTitle = List();
  var max = 0;
  var electricity;

  setMax(max) {
    this.max = max;
  }

  setElectricity(electricity) {
    this.electricity = electricity;
  }

  @override
  onInit() {
    super.onInit();
    apiGraph();
    const duration = const Duration(seconds: 5);
    new Timer.periodic(duration, (Timer t) => apiGraph());
  }

  apiGraph() async {
    // tokenFunction.tokenCheck();

    var url = Env.url + '/api/device/manager/energy/chart';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': '1',
    });
    var data = utf8.decode(response.bodyBytes);
    // print("data: " + data.toString());
    graphData = jsonDecode(data) as Map;
    spotList = makeSpot();
    // print(spot.toString());
    for (int i = 0; i < 5; i++) {
      leftTitle.add((graphData["max"] / 4 * i).round());
    }

    setMax(graphData['max'].toInt());
    setElectricity(spotList);

    print(spotList);

    update();
  }

  List<FlSpot> makeSpot() {
    List<FlSpot> spotList = [];
    if (graphData == null) {
      for (int i = 0; i < 13; i++) spotList.add(FlSpot(i.toDouble(), 0.0));
      return spotList;
    }

    for (int i = 1; i < 13; i++) {
      spotList.add(FlSpot(
          i.toDouble(), graphData["electricity"][12 - i]["watt"].toDouble()));
    }
    return spotList;
  }
}
