import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/addPicture.dart';
import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

List<dynamic> imageList = List(6);

class AddBuyScreen extends StatefulWidget {
  @override
  AddBuyScreenState createState() => AddBuyScreenState();
}

class AddBuyScreenState extends State<AddBuyScreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _price = new TextEditingController();
  TextEditingController _info = new TextEditingController();
  final token = new FlutterSecureStorage();
  final tokenFunction = TokenFunction();

  upload() async {
    var url = Env.url + '/api/campsite/manager/add';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': myToken});
    request.fields.addAll({
      'name': _name.text,
      'price': _price.text,
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
                '구매 물품 추가',
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
                          Text('물품 이름'),
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
                          Text('물품 가격'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: '캠핑장 주소'),
                        controller: _price,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text('물품 정보'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: '캠핑장 전화번호'),
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
