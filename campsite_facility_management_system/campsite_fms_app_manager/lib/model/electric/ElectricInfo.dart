import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/token.dart';
import 'package:campsite_fms_app_manager/model/electric/ElectricData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ElectricInfo extends StatefulWidget {
  @override
  ElectricInfoState createState() => ElectricInfoState();
}

class ElectricInfoState extends State<ElectricInfo> {
  final token = new FlutterSecureStorage();
  ElectricData data;
  bool isSwitched = false;

  Future<Null> _getData() async {
    var url = Env.url + '/api/campsite/manager/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    });

    var d = utf8.decode(response.bodyBytes);

    setState(() {
      data = jsonDecode(d) as ElectricData;
      if (data.switchStatus == 1) {
        isSwitched = true;
      } else {
        isSwitched = false;
      }
    });
  }

  Future<Null> _changeStatus() async {
    var url = Env.url + '/api/campsite/manager/list';
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
      'status': status.toString(),
    });
    print(response.statusCode);
  }

  @override
  void initState() {
    super.initState();
    _getData();
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
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.white),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Column(
                  children: [
                    Text('캠핑장이름, uuid 임시'),
                    // Text(data.name),
                    // Text(data.uuid),
                  ],
                ),
              ),
              Container(
                child: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;

                        print(isSwitched);
                        _changeStatus();
                      });
                    }),
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
                    Text('사용량'),
                    // Text(data.usage),
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
                    Text('예상요금'),
                    // Text(data.charge),
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
