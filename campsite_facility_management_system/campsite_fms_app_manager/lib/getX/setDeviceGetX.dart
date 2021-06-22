import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/screen/homePage/campDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SetDeviceGetX extends GetxController {
  final token = FlutterSecureStorage();
  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();
  bool isDiscovering;
  BluetoothConnection connection;
  var selectedWifi;
  TextEditingController password;
  var bluetoothName;
  var uuid;

  setSelectedWifi(id) {
    selectedWifi = id;
  }

  sendWifiData(password) async {
    connection.output.add(
        utf8.encode(selectedWifi.toString() + password.toString() + '\r\n'));
    await connection.output.allSent;

    connection.input.listen((Uint8List data) {
      print('와이파이 설정 응답: ' + Utf8Decoder().convert(data));

      return Utf8Decoder().convert(data);
    });
  }

  upload(deviceName, categoryId, campsiteId) async {
    var url = Env.url + '/api/device/manager/add';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': myToken});
    request.fields.addAll({
      'name': deviceName.text,
      'uuid': uuid.text,
      'category_id': categoryId.toString(),
      'campsite_id': campsiteId,
    });

    var response = await request.send();

    if (response.statusCode == 200) {
      // Navigator.pushNamed(context, '/campDetail');
      Get.off(CampDetailScreen());
    } else if (response.statusCode == 401) {
      // print("error");
    }
  }
}
