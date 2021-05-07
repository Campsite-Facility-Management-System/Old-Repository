import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/model/homePage/camp/campData.dart';
import 'package:campsite_fms_app_manager/model/homePage/camp/myCamp.dart';
import 'package:campsite_fms_app_manager/model/homePage/profile.dart';
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
  var resCount = '0';
  var ordCount = '0';
  List<dynamic> list;

  Future<Null> _getData() async {
    var url = Env.url + '/api/campsite/manager/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    });

    var d = utf8.decode(response.bodyBytes);

    setState(() {
      list = jsonDecode(d) as List;
    });

    // print(list.length);

    // for (int i = 0; i < list.length; i++) {
    //   print('index: ' + i.toString() + list[i].toString());
    // }
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
        itemCount: list == null ? 0 : list?.length,
        itemBuilder: (context, index) {
          // print("index: " + index.toString());
          // print("list index: " + list[index].toString());
          return MyCamp.buildTile(context, list[index]);
        },
      ),
    );
  }
}
