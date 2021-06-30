<<<<<<< Updated upstream
import 'dart:async';

import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
import 'package:campsite_fms_app_manager/getX/electricGetX.dart';
import 'package:campsite_fms_app_manager/getX/electricGraphGetX.dart';
import 'package:campsite_fms_app_manager/model/electric/category/electricCategoryList.dart';
import 'package:campsite_fms_app_manager/model/electric/category/electricCategoryTile.dart';
import 'package:campsite_fms_app_manager/provider/electricProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
=======
import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/campList.dart';
import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
import 'package:campsite_fms_app_manager/model/electric/category/electricCategoryList.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
>>>>>>> Stashed changes
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ElectricListScreen extends StatefulWidget {
  @override
  ElectricListScreenState createState() => ElectricListScreenState();
}

class ElectricListScreenState extends State<ElectricListScreen> {
<<<<<<< Updated upstream
  var selectedcampName;
  var selectedIndex;
  var selectedId;
  var campId;
  bool refreshListener = false;
  final provider = new ElectricProvider();
=======
  var selected;
  var selectedIndex;
  var selectedId;
  var campId;
>>>>>>> Stashed changes
  final token = new FlutterSecureStorage();
  final tokenFunction = new TokenFunction();
  List<String> campNameList = [];
  List<String> campIdList = [];

<<<<<<< Updated upstream
  @override
  void initState() {
    super.initState();
=======
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
>>>>>>> Stashed changes
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    final controller = Get.put(ElectricGetX());
    final detailController = Get.put(ElectricGraphGetX());
=======
>>>>>>> Stashed changes
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            DropdownButton(
<<<<<<< Updated upstream
              value: controller.selectedCampName,
              items: controller.campNameList.map(
=======
              value: selected,
              items: campNameList.map(
>>>>>>> Stashed changes
                (value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
<<<<<<< Updated upstream
                  controller.setSelectedCampName(value);
                  selectedIndex = controller.campNameList.indexOf(value);
                  controller
                      .setSelectedCampId(controller.campIdList[selectedIndex]);
=======
                  selected = value;
                  selectedIndex = campNameList.indexOf(value);
                  // print("selected: " + selected);
                  // print("selectedIndex: " + selectedIndex.toString());
                  // print("selectedId: " + campIdList[selectedIndex].toString());
>>>>>>> Stashed changes
                });
              },
            ),
            SizedBox(
<<<<<<< Updated upstream
              height: 10,
            ),
            GetBuilder<ElectricGetX>(
              builder: (_) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('새로고침'),
                        onPressed: () => {controller.apiElectricCategoryList()},
                      ),
                      Container(
                        height: 650,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: ListView.builder(
                          // shrinkWrap: true,
                          itemCount: controller.detailData == null
                              ? 0
                              : controller.detailData?.length,
                          itemBuilder: (context, index) {
                            return ElectricCategoryTile.buildTile(
                                context, controller.detailData[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
=======
              height: 50,
            ),
            Container(
              child: ElectricCategoryList(campIdList[selectedIndex].toString()),
            )
>>>>>>> Stashed changes
          ],
        ),
      ),
    );
  }
}
