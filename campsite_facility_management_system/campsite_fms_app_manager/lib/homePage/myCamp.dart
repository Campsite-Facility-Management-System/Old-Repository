import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:campsite_fms_app_manager/function/myInfo.dart';

class MyCampScreen extends StatefulWidget {
  @override
  MyCampScreenState createState() => MyCampScreenState();
}

class MyCampScreenState extends State<MyCampScreen> {
  final token = new FlutterSecureStorage();
  final myInfo = new MyInfo();
  String campName = 'defaule camp name';
  var resCount = '0';
  var ordCount = '0';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        children: <Widget>[
          Text('Image'),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  campName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                flex: 4,
                child: RaisedButton(
                  child: Text('등록/수정'),
                  onPressed: null,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('예약: ' + resCount.toString() + '건'),
              SizedBox(
                width: 20,
              ),
              Text('주문: ' + ordCount.toString() + '건'),
            ],
          ),
        ],
      ),
    );
  }
}
