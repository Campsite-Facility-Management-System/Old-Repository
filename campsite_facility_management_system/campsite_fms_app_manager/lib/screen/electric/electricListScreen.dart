import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/campList.dart';
import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
import 'package:campsite_fms_app_manager/model/electric/category/electricCategoryList.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ElectricListScreen extends StatefulWidget {
  @override
  ElectricListScreenState createState() => ElectricListScreenState();
}

class ElectricListScreenState extends State<ElectricListScreen> {
  var selected;
  var selectedIndex;
  var selectedId;
  var campId;
  final token = new FlutterSecureStorage();
  final tokenFunction = new TokenFunction();
  List<String> campNameList = [];
  List<String> campIdList = [];

  Future<Null> _getData() async {
    var url = Env.url + '/api/campsite/manager/info';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    });

    // print(data);
    setState(() {
      var new_data = utf8.decode(response.bodyBytes);
      var data = jsonDecode(new_data);

      // print("data: " + data.toString());
      // print("data(name): " + data[0]['name'].toString());
      // print("data(length): " + data.length.toString());
      selectedIndex = 0;

      for (var i = 0; i < data.length; i++) {
        campNameList.add(data[i]['name'].toString());
        campIdList.add(data[i]['id'].toString());
      }

      // print(campNameList);
      // print('idList: ' + campIdList.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            DropdownButton(
              value: selected,
              items: campNameList.map(
                (value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  selected = value;
                  selectedIndex = campNameList.indexOf(value);
                  // print("selected: " + selected);
                  // print("selectedIndex: " + selectedIndex.toString());
                  // print("selectedId: " + campIdList[selectedIndex].toString());
                });
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: ElectricCategoryList(campIdList[selectedIndex].toString()),
            )
          ],
        ),
      ),
    );
  }
}
