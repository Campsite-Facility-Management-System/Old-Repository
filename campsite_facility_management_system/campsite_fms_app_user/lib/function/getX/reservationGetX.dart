import 'dart:convert';

import 'package:campsite_fms_app_user/env.dart';
import 'package:campsite_fms_app_user/screen/homePage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReservationGetX extends GetxController {
  var device_id;
  var start_time;
  var end_time;
  var price;
  var adult_number;
  var car_number;
  var children_number;
  final token = FlutterSecureStorage();

  reservation() async {
    var value = await token.read(key: 'token');
    String myToken = "Bearer" + value.toString();
    var url = Env.url + '/api/reservation/user/booking';

    print('device_id: ' + device_id.toString());
    print('start_time: ' + start_time.toString());
    print('end_time: ' + end_time.toString());
    print('price: ' + price.toString());
    print('adult_num: ' + adult_number.toString());
    print('car_num: ' + car_number.toString());
    print('children_num: ' + children_number.toString());

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': device_id.toString(),
      'start_time': start_time.toString(),
      'end_time': end_time.toString(),
      'price': price.toString(),
      'adult_num': adult_number.toString(),
      'car_num': car_number.toString(),
      'children_num': children_number.toString(),
    });

    print("예약 응답 데이터: " + response.body);

    if (response.statusCode == 200) {
      print("success");
      Get.offAll(HomePage());
    } else {
      print(response.statusCode.toString());
      return false;
    }
  }
}
