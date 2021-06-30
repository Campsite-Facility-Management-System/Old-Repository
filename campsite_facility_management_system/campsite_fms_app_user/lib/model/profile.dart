import 'package:cached_network_image/cached_network_image.dart';
import 'package:campsite_fms_app_user/env.dart';
import 'package:campsite_fms_app_user/function/gateway.dart';
import 'package:campsite_fms_app_user/function/myInfo.dart';
import 'package:campsite_fms_app_user/function/getX/tokenGetX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final gateway = Gateway();
  final token = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final tokenController = Get.put(TokenGetX());

    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: FutureBuilder<MyInfo>(
        future: gateway.me(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 90,
                        child: ListTile(
                          title: new CachedNetworkImage(
                            imageBuilder: (BuildContext context,
                                ImageProvider imageProvider) {
                              return AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.black12),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                            imageUrl: Env.url + snapshot.data.img_url,
                            placeholder: (context, url) => Container(
                              height: 100,
                              width: 100,
                            ),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data.nick != null
                                  ? snapshot.data.nick
                                  : 'null',
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              '포인트: ' +
                                  (snapshot.data.point != null
                                      ? snapshot.data.point
                                      : 'null') +
                                  ' Point',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      RaisedButton(
                        color: Colors.green,
                        onPressed: () => tokenController.logout(),
                        child: Text(
                          '로그아웃',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Icon(
                  Icons.error_outline,
                  size: 50,
                ),
                Text('Error: ${snapshot.error}'),
              ],
            );
          } else {
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 50,
                  height: 50,
                ),
                Text('Loading...'),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
