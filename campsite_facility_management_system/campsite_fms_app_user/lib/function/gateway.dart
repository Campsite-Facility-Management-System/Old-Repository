import 'package:campsite_fms_app_user/env.dart';
import 'package:campsite_fms_app_user/function/myInfo.dart';
import 'package:campsite_fms_app_user/function/token/tokenFunction.dart';
// import 'package:campsite_fms_app_user/provider/electricProvider.dart';
import 'package:campsite_fms_app_user/provider/idCollector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class Gateway {
  final token = new FlutterSecureStorage();
  final provider = new IdCollector();
  final tokenFunction = new TokenFunction();

  Future<MyInfo> me(context) async {
    tokenFunction.tokenCheck(context);

    var url = Env.url + '/api/auth/me';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    final response = await http.post(url, headers: {
      'Authorization': myToken,
    });

    Map<String, dynamic> list = jsonDecode(response.body);

    return MyInfo(
      nick: list['nick_name'],
      point: list['point'].toString(),
      img_url: list['profile_img'].toString(),
    );
  }

  Future<List<dynamic>> getCampList(context) async {
    tokenFunction.tokenCheck(context);

    List<dynamic> campList;
    var url = Env.url + '/api/campsite/user/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.get(url, headers: {
      'Authorization': myToken,
    });

    var d = utf8.decode(response.bodyBytes);
    campList = jsonDecode(d) as List;

    return campList;
  }

  Future<Null> getCategoryList(context) async {
    tokenFunction.tokenCheck(context);

    var url = Env.url + '/api/category/user/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);
    List ciList = new List();
    List cnList = new List();
    List<dynamic> categoryList;

    // print("provider id: " +
    //     Provider.of<IdCollector>(context, listen: true)
    //         .selectedCampId
    //         .toString());
    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'campsite_id': Provider.of<IdCollector>(context, listen: true)
          .selectedCampId
          .toString(),
    });
    var data = utf8.decode(response.bodyBytes);
    categoryList = jsonDecode(data) as List;

    for (var i = 0; i < categoryList.length; i++) {
      Provider.of<IdCollector>(context, listen: true)
          .setCMap(categoryList[i]['id'], categoryList[i]['name']);
    }
  }

  //카테고리 디바이스 리스트 작성 중
  Future<Null> getCategoryDeviceList(context) async {
    tokenFunction.tokenCheck(context);

    var url = Env.url + '/api/reservation/user/detail/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);
    List ciList = new List();
    List cnList = new List();
    List<dynamic> categoryList;

    // print("provider id: " +
    //     Provider.of<IdCollector>(context, listen: true)
    //         .selectedCampId
    //         .toString());
    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'id': Provider.of<IdCollector>(context, listen: true)
          .selectedCampId
          .toString(),
    });
    var data = utf8.decode(response.bodyBytes);
    categoryList = jsonDecode(data) as List;

    for (var i = 0; i < categoryList.length; i++) {
      Provider.of<IdCollector>(context, listen: true)
          .setCMap(categoryList[i]['id'], categoryList[i]['name']);
    }
  }
}
