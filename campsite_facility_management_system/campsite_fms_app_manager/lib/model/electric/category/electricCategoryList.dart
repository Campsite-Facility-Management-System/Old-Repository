import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/model/electric/category/electricCategoryTile.dart';
import 'package:campsite_fms_app_manager/provider/electricProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class ElectricCategoryList extends StatefulWidget {
  final String campId;
  const ElectricCategoryList(this.campId);

  @override
  ElectricCategoryListState createState() => ElectricCategoryListState();
}

class ElectricCategoryListState extends State<ElectricCategoryList> {
  final token = new FlutterSecureStorage();
  var data;

  Future<Null> _getDetailData() async {
    var url = Env.url + '/api/device/manager/energy/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    print("campId: " + widget.campId);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'campsite_id': widget.campId,
    });

    print(response.body);
    var newData = utf8.decode(response.bodyBytes);
    data = jsonDecode(newData);
    setState(() {});
  }

  @override
  void initState() {
    _getDetailData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text('캠핑장 변경/새로고침'),
          onPressed: () => {_getDetailData()},
        ),
        Container(
          height: 650,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: data == null ? 0 : data?.length,
            itemBuilder: (context, index) {
              // print("index: " + index.toString());
              // print("list index: " + categoryList[index].toString());

              return ElectricCategoryTile.buildTile(context, data[index]);
            },
            // separatorBuilder: (context, index) =>
            //     DeviceList(categoryList[index]['id'])
          ),
        ),
      ],
    );
  }
}
