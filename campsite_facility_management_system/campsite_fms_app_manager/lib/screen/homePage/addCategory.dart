import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/addPicture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCategoryScreen extends StatefulWidget {
  @override
  AddCategoryScreenState createState() => AddCategoryScreenState();
}

class AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController _name;
  TextEditingController _price;
  TextEditingController _info;

  final token = new FlutterSecureStorage();

  // upload() async {
  //   var url = Env.url + '/api/auth/campsite';
  //   var response = await http.post(url, body: {
  //     'name': _name,
  //     'price': _price,
  //     'info': _info,
  //   });

  //   if (response.statusCode == 200) {
  //     //print("success");
  //     Navigator.pushNamed(context, '/mainFunction');
  //   } else if (response.statusCode == 401) {
  //     // print("login error");
  //     Navigator.pushNamed(context, '/login');
  //   }
  // }

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
                  child: AddPicture(350, 250),
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
                      child: AddPicture(50, 50),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: AddPicture(50, 50),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: AddPicture(50, 50),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: AddPicture(50, 50),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: AddPicture(50, 50),
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
                          controller: _info,
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
                  onPressed: null,
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
