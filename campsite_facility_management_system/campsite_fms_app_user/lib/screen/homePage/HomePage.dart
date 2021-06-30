import 'package:campsite_fms_app_user/function/campList.dart';
import 'package:campsite_fms_app_user/function/token/tokenFunction.dart';
// import 'package:campsite_fms_app_manager/model/homePage/camp/myCamp.dart';
// import 'package:campsite_fms_app_manager/function/campList.dart';
// import 'package:campsite_fms_app_manager/model/homePage/profile.dart';
// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:campsite_fms_app_user/env.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final token = new FlutterSecureStorage();
  final tokenFunction = TokenFunction();

  _check() async {
    bool result = await tokenFunction.tokenCheck(context);
    if (!result) {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '캠핑장 조회',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              CampList(),
            ],
          ),
        ),
      ),
    );
  }
}
