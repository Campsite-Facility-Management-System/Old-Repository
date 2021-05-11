import 'package:cached_network_image/cached_network_image.dart';
import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/myInfo.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final me = Me();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: FutureBuilder<MyInfo>(
        future: me.me(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.img_url);
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
                              snapshot.data.nick,
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              '포인트: ' + snapshot.data.point + ' Point',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      RaisedButton(
                        color: Colors.green,
                        onPressed: () =>
                            {Navigator.pushNamed(context, '/login')},
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
