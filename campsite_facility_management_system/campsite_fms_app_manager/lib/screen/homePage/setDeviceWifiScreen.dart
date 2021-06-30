import 'package:campsite_fms_app_manager/getX/setDeviceGetX.dart';
import 'package:campsite_fms_app_manager/screen/homePage/addDeviceScreen.dart';
import 'package:campsite_fms_app_manager/screen/homePage/searchDeviceScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetDeviceWifiScreen extends StatefulWidget {
  @override
  SetDeviceWifiScreenState createState() => SetDeviceWifiScreenState();
}

class SetDeviceWifiScreenState extends State<SetDeviceWifiScreen> {
  TextEditingController password = new TextEditingController();
  var selected;

  data() {
    print(password.text);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SetDeviceGetX());
    selected = controller.selectedWifi;
    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text('Wifi 선택'),
            GetBuilder<SetDeviceGetX>(
              builder: (_) {
                return DropdownButton(
                  value: selected,
                  items: controller.wifiList.map(
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
                      controller.setSelectedWifi(value);
                    });
                  },
                );
              },
            ),
            SizedBox(
              height: 100,
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
                controller.sendWifiData(password.text),
              },
            )
          ],
        ),
      )),
    );
  }
}
