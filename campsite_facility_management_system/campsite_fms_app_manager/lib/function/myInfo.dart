import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:campsite_fms_app_manager/env.dart';

class MyInfo {
  final token = new FlutterSecureStorage();
  String nick = 'default nick';
  var point = '0';

  me() async {
    var url = Env.url + '/api/auth/me';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, body: {
      'Authorization': myToken,
    });

    print('response: ' + response.body); // 확인
  }
}
