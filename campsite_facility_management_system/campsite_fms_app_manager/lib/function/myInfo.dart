import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:campsite_fms_app_manager/env.dart';
import 'dart:convert';

class MyInfo {
  String nick;
  String point;

  MyInfo({this.nick, this.point});
}

class Me {
  final token = new FlutterSecureStorage();

  Future<MyInfo> me() async {
    var url = Env.url + '/api/auth/me';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    final response = await http.post(url, headers: {
      'Authorization': myToken,
    });
    //print('me(status): ' + response.statusCode.toString());
    //print('me(body): ' + response.body);

    Map<String, dynamic> list = jsonDecode(response.body);

    //print(list);

    return MyInfo(nick: list['nick_name'], point: list['point'].toString());
  }
}
