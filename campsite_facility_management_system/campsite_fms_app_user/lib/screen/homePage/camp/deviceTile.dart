import 'package:cached_network_image/cached_network_image.dart';
import 'package:campsite_fms_app_user/env.dart';
import 'package:campsite_fms_app_user/function/getX/reservationGetX.dart';
import 'package:campsite_fms_app_user/screen/reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeviceTile {
  static final reservationController = Get.put(ReservationGetX());
  static Widget buildTile(context, item) => Container(
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () => {
                  reservationController.device_id = item['id'],
                  reservationController.price = item['price'],
                  Get.to(ReservationScreen()),
                },
                title: Text(
                  item['name'],
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Text(
                  item['uuid'],
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      );
}
