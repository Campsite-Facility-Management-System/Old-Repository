import 'package:campsite_fms_app_manager/getX/setDeviceGetX.dart';
import 'package:campsite_fms_app_manager/screen/homePage/searchDeviceScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetDeviceWifiScreen extends StatefulWidget {
  @override
  SetDeviceWifiScreenState createState() => SetDeviceWifiScreenState();
}

class SetDeviceWifiScreenState extends State<SetDeviceWifiScreen> {
  TextEditingController password;
  var selected;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SetDeviceGetX());
    var wifiList = Get.arguments;

    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
        child: Column(
          children: [
            Text('Wifi 선택'),
            DropdownButton(
              value: selected,
              items: wifiList.map(
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
                  controller.setSelectedWifi(selected);
                });
              },
            ),
            Text('WiFi 비밀번호'),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'password'),
              controller: password,
            ),
            RaisedButton(
              child: Text('연결하기'),
              onPressed: () => {
                controller.sendWifiData(password),
                Get.off(SearchDeviceScreen()),
              },
            )
          ],
        ),
      )),
    );
  }
}
