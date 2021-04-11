import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:campsite_fms_app_manager/function/myInfo.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final token = new FlutterSecureStorage();
  final myInfo = new MyInfo();
  String nick = 'default nick';
  var point = '0';

  @override
  void initState() {
    myInfo.me();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                    Text(nick),
                    Text('포인트: ' + myInfo.point + ' Point'),
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
      ),
    );
  }
}
