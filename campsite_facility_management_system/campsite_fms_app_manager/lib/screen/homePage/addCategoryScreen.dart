import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/addPicture.dart';
import 'package:campsite_fms_app_manager/function/token/tokenCheck.dart';
import 'package:campsite_fms_app_manager/model/homePage/camp/myCamp.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:campsite_fms_app_manager/screen/homePage/campDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

List<dynamic> imageList = List(6);

class AddCategoryScreen extends StatefulWidget {
  @override
  AddCategoryScreenState createState() => AddCategoryScreenState();
}

class AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _price = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  TextEditingController _max_car_num = new TextEditingController();
  TextEditingController _max_adult_num = new TextEditingController();
  TextEditingController _max_children_num = new TextEditingController();
  TextEditingController _max_energy = new TextEditingController();
  final token = new FlutterSecureStorage();
  final tokenCheck = Token();

  _check() async {
    bool result = await tokenCheck.tokenCheck();
    if (!result) {
      Navigator.pushNamed(context, '/login');
    }
  }

  getimage(imagePath, index) {
    imageList[index] = imagePath;

    for (int i = 0; i < 6; i++) {
      print("index: " + i.toString() + " : " + imageList[i].toString());
    }
  }

  upload() async {
    var url = Env.url + '/api/category/manager/add';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': myToken});
    request.fields.addAll({
      'campsite_id': Provider.of<IdCollector>(context, listen: true)
          .selectedCampId
          .toString(),
      'name': _name.text,
      'price': _price.text,
      'description': _description.text,
      'max_car_num': _max_car_num.text,
      'max_adult_num': _max_adult_num.text,
      'max_children_num': _max_children_num.text,
      'max_energy': _max_energy.text
    });

    for (int i = 0; i < 6; i++) {
      if (imageList[i] != null) {
        request.files
            .add(await http.MultipartFile.fromPath('img[]', imageList[i]));
      }
    }
    var response = await request.send();
    // print(request.headers);
    // print(request.fields);
    // print(request.files);

    // print(response.statusCode);
    // print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      print("success");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CampDetailScreen()),
      ).then((value) => setState(() {}));
    } else if (response.statusCode == 401) {
      // print("error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Text(
                  '카테고리 추가',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('대표사진(필수)'),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  height: 200,
                  child: AddPicture(350, 250, 0, 2),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('추가 사진(최대 5개)'),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      child: AddPicture(50, 50, 1, 2),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: AddPicture(50, 50, 2, 2),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: AddPicture(50, 50, 3, 2),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: AddPicture(50, 5, 4, 2),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: AddPicture(50, 50, 5, 2),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Form(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('카테고리 이름'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '카테고리 이름'),
                          controller: _name,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('가격'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: '가격'),
                          controller: _price,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('카테고리 설명'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '카테고리 설명'),
                          controller: _description,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('최대 차량 수'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '최대 차량 수'),
                          controller: _max_car_num,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('최대 성인 수'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '최대 성인 수'),
                          controller: _max_adult_num,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('최대 미성년자 수'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '최대 미성년자 수'),
                          controller: _max_children_num,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('최대 부하량'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: '최대 부하량'),
                          controller: _max_energy,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () => upload(),
                  child: Text('등록하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
