import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:campsite_fms_app_manager/env.dart';
import 'package:http/http.dart' as http;

class Token {
  final token = new FlutterSecureStorage();

  Future<bool> tokenCheck() async {
    var url = Env.url + '/api/auth/check';
    String value = await token.read(key: 'token');
    String myToken = "Bearer" + value.toString();

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    });

    print('tokenCheck(myToken): ' + myToken);
    print('tokenCheck(response.body): ' + response.body);

    var data = jsonDecode(response.body);

    if (data['status'] == 'success') {
      return true;
    } else if (data['status'] == 'Expired') {
      return tokenRefresh();
    } else if (data['status'] == 'Invalid') {
      print("tokenCheck error: Invalid");
    } else if (data['status'] == 'Unknown') {
      print("tokenCheck error: Unknown");
    }
    return false;
  }

  Future<bool> tokenRefresh() async {
    var url = Env.url + '/api/auth/refresh';
    String value = await token.read(key: 'token');
    String myToken = "Bearer" + value.toString();

    var refresh = await http.post(url, headers: {
      'Authorization': myToken,
    });
    // print('refresh' + refresh.body.toString());

    if (refresh.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(refresh.body);
      await token.write(key: 'token', value: result['access_token']);
      print("tokenRefresh success");
    } else {
      print("tokenRefresh error");
    }
    return true;
  }
}
