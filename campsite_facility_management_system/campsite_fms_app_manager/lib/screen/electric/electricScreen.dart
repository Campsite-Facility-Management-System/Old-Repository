import 'package:campsite_fms_app_manager/function/mainFunction.dart';
import 'package:campsite_fms_app_manager/function/token/tokenFunction.dart';
import 'package:campsite_fms_app_manager/model/electric/electricGraph.dart';
import 'package:campsite_fms_app_manager/model/electric/electricInfo.dart';
import 'package:flutter/material.dart';

class ElectricScreen extends StatefulWidget {
  @override
  ElectricScreenState createState() => ElectricScreenState();
}

class ElectricScreenState extends State<ElectricScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  final tokenFuntion = TokenFunction();

  _check() async {
    bool result = await tokenFuntion.tokenCheck(context);
    if (!result) {
      Navigator.pushNamed(context, '/login');
    }
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => MainFunction()));
    });

    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
            title: Text('기기정보'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ElectricInfo(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 30),
                  child: Text('전력 사용량 그래프'),
                ),
                SizedBox(
                  height: 10,
                ),
                ElectricGraph(),
              ],
            ),
          ),
        ),
      ),
      onRefresh: refreshList,
      key: refreshKey,
    );
  }
}
