import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/addPicture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCampScreen extends StatefulWidget {
  @override
  AddCampScreenState createState() => AddCampScreenState();
}

class AddCampScreenState extends State<AddCampScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _addr = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _intro = new TextEditingController();
  final token = new FlutterSecureStorage();

  upload() async {
    var url = Env.url + '/api/auth/campsite';
    var response = await http.post(url, body: {
      'name': _name,
      'address': _addr,
      'telephone': _phone,
      'description': _intro,
    });

    if (response.statusCode == 200) {
      //print("success");
      Navigator.pushNamed(context, '/mainFunction');
    } else if (response.statusCode == 401) {
      // print("login error");
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Text(
                '캠핑장 추가',
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
                child: AddPicture(350, 200),
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
                          Text('캠핑장 이름'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: '캠핑장 이름'),
                        controller: _name,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text('캠핑장 주소'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: '캠핑장 주소'),
                        controller: _addr,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text('캠핑장 전화번호'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: '캠핑장 전화번호'),
                        controller: _phone,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text('캠핑장 소개'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: '캠핑장 소개'),
                        controller: _intro,
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
    );
  }
}

/*
  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> image) {
        if (image.connectionState == ConnectionState.done &&
            null != image.data) {
          tmp = image.data;
          base64Image = base64Encode(image.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              image.data,
              fit: BoxFit.fill,
            ),
          );
        } else {
          return Text(
            '이미지를 선택해주세요',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
              ),
              Text('캠핑장 추가'),
              Text('대표사진'),
              OutlineButton(
                  onPressed: () => getImage(), child: Icon(Icons.add_a_photo)),
            ],
          ),
        ),
      ),
    );
  }
}
*/
