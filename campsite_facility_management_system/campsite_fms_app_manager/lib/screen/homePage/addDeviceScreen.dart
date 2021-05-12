import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/token/tokenCheck.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddDeviceScreen extends StatefulWidget {
  @override
  AddDeviceScreenState createState() => AddDeviceScreenState();
}

class AddDeviceScreenState extends State<AddDeviceScreen> {
  TextEditingController _uuid = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  final token = new FlutterSecureStorage();
  final tokenCheck = Token();

  _check() async {
    bool result = await tokenCheck.tokenCheck();
    if (!result) {
      Navigator.pushNamed(context, '/login');
    }
  }

  var selected;
  var selectedIndex;

  upload() async {
    var url = Env.url + '/api/device/manager/add';
    String value = await token.read(key: 'token');
    String myToken = ("Bearer " + value);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': myToken});
    request.fields.addAll({
      'name': _name.text,
      'uuid': _uuid.text,
      'category_id': selectedIndex.toString(),
      'campsite_id': Provider.of<IdCollector>(context, listen: true)
          .selectedCampId
          .toString(),
    });

    var response = await request.send();
    // print(request.headers);
    // print(request.fields);

    // print(response.statusCode);
    // print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      // print("success");
      Navigator.pushNamed(context, '/campDetail');
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
    // List ciList = Provider.of<IdCollector>(context, listen: true).ciList;
    // List cnList = Provider.of<IdCollector>(context, listen: true).cnList;
    //selected = cnList[0];
    Map<String, int> cMap =
        Provider.of<IdCollector>(context, listen: true).cMap;

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
                        DropdownButton(
                          value: selected,
                          items: cMap.keys.map(
                            (value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              selected = value;
                              selectedIndex = cMap[selected];
                              print("selected: " + selected);
                              print(cMap[selected]);
                            });
                          },
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
