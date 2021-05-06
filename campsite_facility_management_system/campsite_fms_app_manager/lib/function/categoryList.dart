import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/model/homePage/camp/campData.dart';
import 'package:campsite_fms_app_manager/model/homePage/camp/myCamp.dart';
import 'package:campsite_fms_app_manager/model/homePage/category/categoryTile.dart';
import 'package:campsite_fms_app_manager/model/homePage/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryList extends StatefulWidget {
  final int camp;

  const CategoryList(this.camp);

  @override
  CategoryListState createState() => CategoryListState();
}

class CategoryListState extends State<CategoryList> {
  final token = new FlutterSecureStorage();
  List<dynamic> categoryList;

  Future<Null> _getData() async {
    var url = Env.url + '/api/category/manager/list';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    print(widget.camp);
    var response = await http.post(url, headers: {
      'Authorization': myToken,
    }, body: {
      'campsite_id': widget.camp.toString(),
    });
    var data = utf8.decode(response.bodyBytes);
    print(data.toString());
    setState(() {
      categoryList = jsonDecode(data) as List;
    });

    for (int i = 0; i < categoryList.length; i++) {
      print('categoryList: ' + i.toString() + categoryList[i].toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      height: 610,
      child: ListView.builder(
        itemCount: categoryList == null ? 0 : categoryList?.length,
        itemBuilder: (context, index) {
          print("index: " + index.toString());
          print("list index: " + categoryList[index].toString());
          return CategoryTile.buildTile(context, categoryList[index]);
        },
      ),
    );
  }
}
