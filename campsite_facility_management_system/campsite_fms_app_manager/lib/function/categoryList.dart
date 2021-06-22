import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/deviceList.dart';
import 'package:campsite_fms_app_manager/function/gateway.dart';
import 'package:campsite_fms_app_manager/getX/campDetailGetX.dart';
import 'package:campsite_fms_app_manager/model/homePage/camp/campData.dart';
import 'package:campsite_fms_app_manager/model/homePage/camp/myCamp.dart';
import 'package:campsite_fms_app_manager/model/homePage/category/categoryTile.dart';
import 'package:campsite_fms_app_manager/model/homePage/profile.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  @override
  CategoryListState createState() => CategoryListState();
}

class CategoryListState extends State<CategoryList> {
  final token = new FlutterSecureStorage();
  List<dynamic> categoryList;
  final provider = IdCollector();

  Future<Null> _getData() async {
    var url = Env.url + '/api/category/manager/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'campsite_id': Provider.of<IdCollector>(context, listen: true)
          .selectedCampId
          .toString(),
    });
    var data = utf8.decode(response.bodyBytes);
    // print("data: " + data.toString());
    setState(() {
      categoryList = jsonDecode(data) as List;
    });

    for (var i = 0; i < categoryList.length; i++) {
      Provider.of<IdCollector>(context, listen: true)
          .setCMap(categoryList[i]['id'], categoryList[i]['name']);
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CampDetailGetX());
    controller.getData();
    return Container(
      height: 650,
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: GetBuilder<CampDetailGetX>(
        builder: (_) {
          return ListView.builder(
            // shrinkWrap: true,
            itemCount: categoryList == null ? 0 : categoryList?.length,
            itemBuilder: (context, index) {
              return CategoryTile.buildTile(
                  context, controller.categoryList[index]);
            },
          );
        },
      ),
    );
  }
}
