import 'package:cached_network_image/cached_network_image.dart';
import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/getX/campDetailGetX.dart';
import 'package:campsite_fms_app_manager/model/homePage/profile.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:campsite_fms_app_manager/screen/homePage/addCampScreen.dart';
import 'package:campsite_fms_app_manager/screen/homePage/campDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class MyCamp {
  static final controller = Get.put(CampDetailGetX());

  static Widget buildTile(context, item) => Container(
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          // padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                title: new CachedNetworkImage(
                  imageBuilder:
                      (BuildContext context, ImageProvider imageProvider) {
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        // border: Border.all(width: 0.5, color: Colors.black12),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: imageProvider,
                        ),
                      ),
                    );
                  },
                  imageUrl: Env.url + item['img_url'],
                  placeholder: (context, url) => Container(
                    height: 100,
                    child: SizedBox(
                      height: 100,
                    ),
                  ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
              ListTile(
                title: Text(
                  item['name'],
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  item['address'],
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              ListTile(
                title: RaisedButton(
                  color: Colors.green,
                  onPressed: () => {
                    Provider.of<IdCollector>(context, listen: false)
                        .setCampId(item['id']),
                    controller.selectedCampId = item['id'],
                    Navigator.pushNamed(context, '/campDetail')
                  },
                  child: Text(
                    '관리',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

// Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('예약: ' + '건'),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Text('주문: ' + '건'),
//                   ],
//                 ),
