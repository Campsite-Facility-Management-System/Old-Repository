import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/model/homePage/camp/campData.dart';
import 'package:campsite_fms_app_manager/model/homePage/camp/myCamp.dart';
import 'package:campsite_fms_app_manager/model/homePage/device/deviceTile.dart';
import 'package:campsite_fms_app_manager/model/homePage/profile.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class DeviceList extends StatefulWidget {
  final int category;
  const DeviceList(this.category);

  @override
  DeviceListstate createState() => DeviceListstate();
}

class DeviceListstate extends State<DeviceList> {
  final token = new FlutterSecureStorage();
  List<dynamic> deviceList;

  Future<Null> _getData() async {
    var url = Env.url + '/api/device/manager/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    // print("widget.category: " + widget.category.toString());
    // print("campsite_id: " +
    //     Provider.of<IdCollector>(context, listen: true)
    //         .selectedCampId
    //         .toString());
    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'campsite_id': Provider.of<IdCollector>(context, listen: true)
          .selectedCampId
          .toString(),
      'category_id': widget.category.toString(),
    });

    var data = utf8.decode(response.bodyBytes);
    // print(data);
    setState(() {
      deviceList = jsonDecode(data) as List;
    });

    // for (int i = 0; i < deviceList.length; i++) {
    //   print('index: ' + i.toString() + deviceList[i].toString());
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
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: deviceList == null ? 0 : deviceList?.length,
        itemBuilder: (context, index) {
          // print("index: " + index.toString());
          // print("list index: " + deviceList[index].toString());
          return DeviceTile.buildTile(context, deviceList[index]);
        },
      ),
    );
  }
}
