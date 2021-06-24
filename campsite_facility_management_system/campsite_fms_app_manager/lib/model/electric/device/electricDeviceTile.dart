import 'package:campsite_fms_app_manager/getX/electricGraphGetX.dart';
import 'package:campsite_fms_app_manager/screen/electric/electricScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricDeviceTile {
  static final controller = Get.put(ElectricGraphGetX());
  static Widget buildTile(context, item) => Container(
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: ListTile(
                    onTap: () => {
                      controller.setDeviceId(item['id'].toString()),
                      controller.apiDeviceStatus(),
                      controller.apiUsageData(),
                      controller.apiGraph(),
                      Get.to(ElectricScreen()),
                    },
                    title: Text(
                      item['name'],
                      style: TextStyle(fontSize: 25),
                    ),
                    subtitle: Text(
                      item['usage'].toString() + 'kw',
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Text(
                      item['state'].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
