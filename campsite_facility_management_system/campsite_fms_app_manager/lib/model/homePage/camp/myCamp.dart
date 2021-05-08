import 'package:cached_network_image/cached_network_image.dart';
import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:campsite_fms_app_manager/screen/homePage/addCampScreen.dart';
import 'package:campsite_fms_app_manager/screen/homePage/campDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class MyCamp {
  // static setCampId(campId) {
  //   print("parameter: " + campId.toString());
  //   provider.setCampId(campId);
  //   print("provider: " + provider.selectedCampId.toString());
  //   print(provider.selectedCampId.toString());
  // }

  static Widget buildTile(context, item) => Container(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            children: <Widget>[
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
                title: Text("캠핑장 이름: " + item['name']),
              ),
              ListTile(
                title: RaisedButton(
                  onPressed: () => {
                    print("item: " + item['id'].toString()),
                    Provider.of<IdCollector>(context, listen: false)
                        .setCampId(item['id']),
                    // setCampId(item['id']),
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CampDetailScreen()))

                    // Navigator.pushNamed(context, '/campDetail')
                  },
                  child: Text('관리'),
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
