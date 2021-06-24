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
  var deviceName;
  var uuid;
  var usage;
  var charge;
  var statusData;
  bool isSwitched = false;
  Map<String, dynamic> usageData;
  var campId;
  var deviceId;

  loop() {
    const duration = const Duration(seconds: 5);
    new Timer.periodic(duration, (Timer t) => apiGraph());
    new Timer.periodic(duration, (Timer t) => apiUsageData());
  }

  setCampId(camdId) {
    this.campId = campId;
  }

  setDeviceId(deviceId) {
    this.deviceId = deviceId;
  }

  setMax(max) {
    this.max = max;
  }

  setElectricity(electricity) {
    this.electricity = electricity;
  }

  setUsage(usage) {
    this.usage = usage;
    update();
  }

  setCharge(charge) {
    this.charge = charge;
    update();
  }

  setStatusData(data) {
    this.statusData = data;
    update();
  }

  setDeviceName(deviceName) {
    this.deviceName = deviceName;
    update();
  }

  setUuid(uuid) {
    this.uuid = uuid;
    update();
  }

  @override
  onInit() {
    super.onInit();
  }

  apiUsageData() async {
    // tokenFunction.tokenCheck(context);

    var url = Env.url + '/api/device/manager/energy/usage';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': deviceId.toString(),
    });

    usageData = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    setUsage(usageData["usage"]);
    setCharge(usageData["charge"]);

    update();
  }

  apiDeviceStatus() async {
    // tokenFunction.tokenCheck(context);

    var url = Env.url + '/api/device/manager/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    print('확인: ' + campId.toString());

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'campsite_id': '1',
      'category_id': '10',
    });

    setStatusData(jsonDecode(utf8.decode(response.bodyBytes)));
    if (statusData[0]["state"] == 0) {
      isSwitched = false;
    } else if (statusData[0]["state"] == 1) {
      isSwitched = true;
    }
    setDeviceName(statusData[0]["name"]);
    setUuid(statusData[0]["uuid"]);

    update();
  }

  apichangeStatus() async {
    // tokenFunction.tokenCheck(context);

    var url = Env.url + '/api/device/manager/controll';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);
    int status;

    if (isSwitched == true) {
      status = 1;
    } else {
      status = 0;
    }

    // print(status.toString());
    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': deviceId.toString(),
      'command': status.toString(),
    });
    print(response.statusCode);

    update();
  }

  apiGraph() async {
    // tokenFunction.tokenCheck();
    spotList.clear();

    var url = Env.url + '/api/device/manager/energy/chart';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': deviceId.toString(),
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
