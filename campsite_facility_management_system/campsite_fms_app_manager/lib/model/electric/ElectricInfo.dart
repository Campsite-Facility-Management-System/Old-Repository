import 'dart:async';

import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/mainFunction.dart';
import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
import 'package:campsite_fms_app_manager/model/electric/usageData.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class ElectricInfo extends StatefulWidget {
  @override
  ElectricInfoState createState() => ElectricInfoState();
}

class ElectricInfoState extends State<ElectricInfo> {
  final token = new FlutterSecureStorage();
  final tokenFunction = new TokenFunction();

  bool isSwitched = false;
  Map<String, dynamic> list;
  var deviceName;
  var uuid;

  Future<Null> getUsageData() async {
    tokenFunction.tokenCheck(context);

    var url = Env.url + '/api/device/manager/energy/usage';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': '1'
    });

    var d = utf8.decode(response.bodyBytes);
    setState(() {
      list = jsonDecode(d) as Map;
      Provider.of<UsageData>(context, listen: true).setUsage(list["usage"]);
      Provider.of<UsageData>(context, listen: true).setCharge(list["charge"]);
      // data = jsonDecode(d);
      // if (data.switchStatus == 1) {
      //   isSwitched = true;
      // } else {
      //   isSwitched = false;
      // }
    });
  }

  Future<Null> getDevice() async {
    tokenFunction.tokenCheck(context);

    var url = Env.url + '/api/device/manager/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);
    List<dynamic> l = List();

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'campsite_id': '1',
      'category_id': '10',
    });

    var d = utf8.decode(response.bodyBytes);
    l = jsonDecode(d) as List;
    if (l[0]["state"] == 0) {
      isSwitched = false;
    } else if (l[0]["state"] == 1) {
      isSwitched = true;
    }
    deviceName = l[0]["name"];
    uuid = l[0]["uuid"];
  }

  Future<Null> _changeStatus() async {
    tokenFunction.tokenCheck(context);

    var url = Env.url + '/api/device/manager/controll';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);
    int status;

    if (isSwitched == true) {
      status = 1;
    } else {
      status = 0;
    }

    // print(status.toString());
    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': '1',
      'command': status.toString(),
    });
    print(response.statusCode);
  }

  @override
  void initState() {
    super.initState();
    getDevice();
    getUsageData();
    const duration = const Duration(seconds: 10);
    new Timer.periodic(duration, (Timer t) => getUsageData());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 40, right: 70, top: 10, bottom: 10),
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.white),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deviceName != null ? deviceName : 'loading',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '<uuid>',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      uuid != null ? uuid : 'loading',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                child: Transform.scale(
                  scale: 4.0,
                  child: Switch(
                    value: isSwitched,
                    activeColor: Colors.green,
                    activeTrackColor: Colors.lightGreen,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;

                        _changeStatus();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.electrical_services_outlined),
                        SizedBox(width: 5),
                        Text(
                          '사용량',
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ChangeNotifierProvider<UsageData>(
                      create: (_) => UsageData(0, 0),
                      child: Consumer<UsageData>(
                          builder: (_, provider, child) => Text(
                                Provider.of<UsageData>(context, listen: true)
                                        .usage
                                        .toString() +
                                    "kW",
                                style: TextStyle(fontSize: 30),
                              )),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.money_rounded),
                        SizedBox(width: 5),
                        Text(
                          '예상요금',
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ChangeNotifierProvider<UsageData>(
                      create: (_) => UsageData(0, 0),
                      child: Consumer<UsageData>(
                        builder: (_, provider, child) => Text(
                          Provider.of<UsageData>(context, listen: true)
                                  .charge
                                  .toString() +
                              "원",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
