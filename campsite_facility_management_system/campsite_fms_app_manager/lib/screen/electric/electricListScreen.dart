import 'dart:async';

import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
import 'package:campsite_fms_app_manager/getX/electricGetX.dart';
import 'package:campsite_fms_app_manager/model/electric/category/electricCategoryList.dart';
import 'package:campsite_fms_app_manager/model/electric/category/electricCategoryTile.dart';
import 'package:campsite_fms_app_manager/provider/electricProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ElectricListScreen extends StatefulWidget {
  @override
  ElectricListScreenState createState() => ElectricListScreenState();
}

class ElectricListScreenState extends State<ElectricListScreen> {
  var selectedcampName;
  var selectedIndex;
  var selectedId;
  var campId;
  bool refreshListener = false;
  final provider = new ElectricProvider();
  final token = new FlutterSecureStorage();
  final tokenFunction = new TokenFunction();
  List<String> campNameList = [];
  List<String> campIdList = [];

  // Future<Null> getData() async {
  //   var url = Env.url + '/api/campsite/manager/info';
  //   String value = await token.read(key: 'token');
  //   String myToken = ("Bearer " + value);

  //   var response = await http.post(url, headers: {
  //     'Authorization': myToken,
  //   });

  //   setState(() {
  //     var newData = utf8.decode(response.bodyBytes);
  //     var data = jsonDecode(newData);

  //     for (var i = 0; i < data.length; i++) {
  //       campNameList.add(data[i]['name'].toString());
  //       campIdList.add(data[i]['id'].toString());
  //     }
  //     selected = campNameList[0];

  //     Provider.of<ElectricProvider>(context, listen: true)
  //         .setCampId(campIdList[0].toString());
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    // _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ElectricGetX());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            DropdownButton(
              value: controller.selectedCampName,
              items: controller.campNameList.map(
                (value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  controller.setSelectedCampName(value);
                  selectedIndex = controller.campNameList.indexOf(value);
                  controller
                      .setSelectedCampId(controller.campIdList[selectedIndex]);
                  // Provider.of<ElectricProvider>(context, listen: true)
                  //     .setCampId(campIdList[selectedIndex].toString());

                  // print("selected: " + selected);
                  // print("selectedIndex: " + selectedIndex.toString());
                  // print("selectedId: " + campIdList[selectedIndex].toString());
                });
              },
            ),
            SizedBox(
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
                            // print("length: " +
                            //     controller.detailData[1].toString());

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
          ],
        ),
      ),
    );
  }
}
