import 'package:cached_network_image/cached_network_image.dart';
import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/deviceList.dart';
import 'package:campsite_fms_app_manager/screen/homePage/addCampScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryTile {
  static Widget buildTile(context, item) => Container(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          padding: EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('카테고리명: ' + item['name']),
              ),
              ListTile(
                title: new CachedNetworkImage(
                  imageBuilder:
                      (BuildContext context, ImageProvider imageProvider) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black12),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  imageUrl: Env.url + item['img_url'],
                  placeholder: (context, url) => Container(
                    height: 500,
                    child: SizedBox(
                      height: 300,
                    ),
                  ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
              ListTile(
                title: DeviceList(item['id']),
              )
            ],
          ),
        ),
      );
}
