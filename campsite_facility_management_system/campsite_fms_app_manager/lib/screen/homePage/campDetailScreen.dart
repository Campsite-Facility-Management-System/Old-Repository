import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/categoryList.dart';
import 'package:campsite_fms_app_manager/model/homePage/camp/myCamp.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CampDetailScreen extends StatefulWidget {
  @override
  CampDetailScreenState createState() => CampDetailScreenState();
}

class CampDetailScreenState extends State<CampDetailScreen> {
  final token = new FlutterSecureStorage();
  static final provider = new IdCollector();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('카테고리/디바이스 목록'),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: CategoryList(),
          ),
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.remove,
          visible: true,
          closeManually: false,
          children: [
            SpeedDialChild(
                child: Icon(Icons.accessibility),
                backgroundColor: Colors.blue,
                label: '카테고리',
                onTap: () => Navigator.pushNamed(
                      context,
                      '/addCategory',
                    )),
            SpeedDialChild(
                child: Icon(Icons.accessibility),
                backgroundColor: Colors.green,
                label: '디바이스',
                onTap: () => Navigator.pushNamed(context, '/addDevice'))
          ],
        ));
  }
}
