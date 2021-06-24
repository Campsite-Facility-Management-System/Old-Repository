import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
import 'package:campsite_fms_app_manager/getX/campDetailGetX.dart';
import 'package:campsite_fms_app_manager/getX/setDeviceGetX.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:campsite_fms_app_manager/screen/homePage/bluetoothScreen.dart';
import 'package:campsite_fms_app_manager/screen/homePage/searchDeviceScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddDeviceScreen extends StatefulWidget {
  @override
  AddDeviceScreenState createState() => AddDeviceScreenState();
}

class AddDeviceScreenState extends State<AddDeviceScreen> {
  var uuid;
  TextEditingController _name = new TextEditingController();
  final token = new FlutterSecureStorage();
  final tokenFunction = TokenFunction();

  _check() async {
    bool result = await tokenFunction.tokenCheck(context);
    if (!result) {
      Navigator.pushNamed(context, '/login');
    }
  }

  var selected;
  var selectedId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check();
  }

  @override
  Widget build(BuildContext context) {
    final campDetailController = Get.put(CampDetailGetX());
    final setDeviceController = Get.put(SetDeviceGetX());

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
                            RaisedButton(
                                child: Text('블루투스 검색'),
                                onPressed: () => {
                                      // Get.to(() => SearchDeviceScreen()),
                                      Navigator.pushNamed(context, '/search'),
                                    }),
                          ],
                        ),
                        SizedBox(
                          height: 20,
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
                            Text('카테고리 선택'),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            DropdownButton(
                              value: selected,
                              items: campDetailController.cMap.keys.map(
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
                                  selectedId =
                                      campDetailController.cMap[selected];
                                  print("selected: " + selected);
                                  print(campDetailController.cMap[selected]);
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () => setDeviceController.upload(
                    _name.text,
                    campDetailController.cMap[selected],
                    campDetailController.selectedCampId,
                  ),
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
