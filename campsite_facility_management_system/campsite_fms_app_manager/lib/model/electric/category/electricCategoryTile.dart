import 'package:campsite_fms_app_manager/model/electric/device/electricDeviceList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ElectricCategoryTile {
  static Widget buildTile(context, item) => Container(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  item['name'],
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: ElectricDeviceList(item['deviceList']),
              )
            ],
          ),
        ),
      );
}
