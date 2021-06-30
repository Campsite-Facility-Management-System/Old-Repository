import 'package:campsite_fms_app_user/env.dart';
import 'package:campsite_fms_app_user/function/gateway.dart';
// import 'package:campsite_fms_app_user/model/homePage/camp/campData.dart';
import 'package:campsite_fms_app_user/screen/homePage/camp/myCamp.dart';
import 'package:campsite_fms_app_user/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CampList extends StatefulWidget {
  @override
  CampListState createState() => CampListState();
}

class CampListState extends State<CampList> {
  final token = new FlutterSecureStorage();
  final gateway = new Gateway();
  var resCount = '0';
  var ordCount = '0';
  List<dynamic> list;

  Future<Null> _getData() async {
    list = await gateway.getCampList(context);

    setState(() {
      list;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: 620,
      child: ListView.builder(
        itemCount: list == null ? 0 : list?.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ProfileScreen();
          } else {
            return MyCamp.buildTile(context, list[index - 1]);
          }
          // print("index: " + index.toString());
          // print("list index: " + list[index].toString());
        },
      ),
    );
  }
}
