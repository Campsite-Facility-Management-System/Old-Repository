import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/addPicture.dart';
import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:campsite_fms_app_manager/env.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<dynamic> imageList = List(6);

class AddCampScreen extends StatefulWidget {
  @override
  AddCampScreenState createState() => AddCampScreenState();
}

class AddCampScreenState extends State<AddCampScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _addr = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _info = new TextEditingController();
  final token = new FlutterSecureStorage();
  final tokenFunction = TokenFunction();

  _check() async {
    bool result = await tokenFunction.tokenCheck(context);
    if (!result) {
      Navigator.pushNamed(context, '/login');
    }
  }

  getimage(imagePath, index) {
    imageList[index] = imagePath;

    for (int i = 0; i < 6; i++) {
      // print("index: " + i.toString() + " : " + imageList[i].toString());
    }
  }

  upload() async {
    var url = Env.url + '/api/campsite/manager/add';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': myToken});
    request.fields.addAll({
      'name': _name.text,
      'telephone': _phone.text,
      'address': _addr.text,
      'description': _info.text,
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

    print(response.statusCode);
    print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      // print("success");
      Navigator.pushNamed(context, '/homePage');
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
                child: AddPicture(350, 200, 0, 1),
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
                    child: AddPicture(50, 50, 1, 1),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    child: AddPicture(50, 50, 2, 1),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    child: AddPicture(50, 50, 3, 1),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    child: AddPicture(50, 50, 4, 1),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    child: AddPicture(50, 50, 5, 1),
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
                        controller: _info,
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
            ),@
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
