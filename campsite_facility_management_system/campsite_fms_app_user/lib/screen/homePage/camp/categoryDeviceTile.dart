import 'package:cached_network_image/cached_network_image.dart';
import 'package:campsite_fms_app_user/env.dart';
import 'package:campsite_fms_app_user/function/getX/categoryDeviceGetX.dart';
import 'package:campsite_fms_app_user/screen/homePage/camp/deviceTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryDeviceTile {
  final controller = Get.put(CategoryDeviceGetX());
  static Widget buildTile(context, item) => Container(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: GetBuilder(
            builder: (_) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: new CachedNetworkImage(
                      imageBuilder:
                          (BuildContext context, ImageProvider imageProvider) {
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.2, color: Colors.black12),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      imageUrl: Env.url + item['img_url'],
                      placeholder: (context, url) => Container(
                        height: 100,
                        child: SizedBox(
                          height: 50,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      item['name'],
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        item['device'] == null ? 0 : item['device']?.length,
                    itemBuilder: (context, index) {
                      // print("index: " + index.toString());
                      // print("list index: " + deviceList[index].toString());
                      return DeviceTile.buildTile(
                          context, item['device'][index]);
                    },
                  ),
                  // ListTile(
                  //   title: DeviceList(item['deviceList']),
                  // )
                ],
              );
            },
          ),
        ),
      );
}
