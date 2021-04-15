import 'package:campsite_fms_app_manager/model/homePage/myCamp.dart';
import 'package:campsite_fms_app_manager/model/homePage/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:campsite_fms_app_manager/env.dart';
import 'dart:convert';

class HomePageScreen extends StatefulWidget {
  @override
  HomePageScreenState createState() => HomePageScreenState();
}

class HomePageScreenState extends State<HomePageScreen> {
  final token = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                ProfileScreen(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '내 캠핑장',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                MyCampScreen(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
