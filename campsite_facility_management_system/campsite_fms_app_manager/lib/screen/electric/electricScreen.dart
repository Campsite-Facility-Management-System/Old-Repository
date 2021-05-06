import 'package:campsite_fms_app_manager/model/electric/ElectricInfo.dart';
import 'package:flutter/material.dart';

class ElectricScreen extends StatefulWidget {
  @override
  ElectricScreenState createState() => ElectricScreenState();
}

class ElectricScreenState extends State<ElectricScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('기기정보'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ElectricInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
