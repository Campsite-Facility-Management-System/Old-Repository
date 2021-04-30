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
      child: FutureBuilder<MyInfo>(
        future: me.me(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: [
                          Text(snapshot.data.nick),
                          Text('포인트: ' + snapshot.data.point + ' Point'),
                        ],
                      ),
                      SizedBox(width: 50),
                      RaisedButton(
                        onPressed: null, //편집 페이지 완성 후 연결해야함
                        child: Text('편집'),
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
/*

      */
