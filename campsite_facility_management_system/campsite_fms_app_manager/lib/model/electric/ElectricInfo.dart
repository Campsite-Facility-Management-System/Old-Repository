import 'dart:async';

import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/mainFunction.dart';
import 'package:campsite_fms_app_manager/function/token.dart';
import 'package:campsite_fms_app_manager/model/electric/usageData.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
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
  bool isSwitched = false;
  Map<String, dynamic> list;

  Future<Null> getUsageData() async {
    var url = Env.url + '/api/device/manager/energy/usage';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': '1'
    });
    print("data" + response.toString());

    var d = utf8.decode(response.bodyBytes);
    print("data" + d);
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

  Future<Null> _changeStatus() async {
    var url = Env.url + '/api/device/manager/controll';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);
    int status;

    if (isSwitched == true) {
      status = 1;
    } else {
      status = 0;
    }

    print(status.toString());
    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'device_id': '1',
      'command': status.toString(),
    });
    // print(response.statusCode);
  }

  @override
  void initState() {
    super.initState();
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
                      'device name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'uuid',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'uuid ads',
                      style: TextStyle(fontSize: 20),
                    ),
                    // data.uuid),
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

                        print(isSwitched);
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
                              )),
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
