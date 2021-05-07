import 'package:cached_network_image/cached_network_image.dart';
import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/screen/homePage/addCampScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeviceTile {
  static Widget buildTile(context, item) => Container(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("기기명: " + item['name']),
              ),
              ListTile(
                title: Text("uuid: " + item['uuid']),
              ),
            ],
          ),
        ),
      );
}
