import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:campsite_fms_app_manager/env.dart';
import 'package:http/http.dart' as http;

class Token {
  final token = new FlutterSecureStorage();

  Future<bool> tokenTest() async {
    bool b = false;
    var url = Env.url + '/api/auth/check';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, body: {
      'Authorization': myToken,
    });

    print(myToken);
    print(response.body);
    if (response.body.contains("success")) {
      b = true;
    }
    return b;
  }
}
