import 'package:campsite_fms_app_manager/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AddDeviceScreen extends StatefulWidget {
  @override
  AddDeviceScreenState createState() => AddDeviceScreenState();
}

class AddDeviceScreenState extends State<AddDeviceScreen> {
  TextEditingController _uuid;
  TextEditingController _name;
  int _category = 0;
  final token = new FlutterSecureStorage();

  upload() async {
    var url = Env.url + '/api/campsite/manager/add';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': myToken});
    request.fields.addAll({
      'name': _name.text,
      'uuid': _uuid.text,
      'category': _category.toString(),
    });

    var response = await request.send();
    print(request.headers);
    print(request.fields);

    print(response.statusCode);
    print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      print("success");
      Navigator.pushNamed(context, '/campDetail');
    } else if (response.statusCode == 401) {
      print("error");
    }
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
                  '디바이스 추가',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Form(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('UUID'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: 'UUID'),
                          controller: _uuid,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('디바이스 이름'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '디바이스 이름'),
                          controller: _name,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('디바이스 이름'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: ListTile(
                            title: Text('카테고리 추가'),
                            trailing: Icon(Icons.arrow_drop_down),
                            onTap: () => {},
                          ),
                        )
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
