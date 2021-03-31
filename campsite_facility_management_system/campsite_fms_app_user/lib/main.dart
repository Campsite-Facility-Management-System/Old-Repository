import 'package:flutter/material.dart';
import 'package:campsite_fms_app_user/sign/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '모닥모닥',
        debugShowCheckedModeBanner: false, //debug ribbon remove
        initialRoute: '/',
        routes: {'/': (context) => LoginScreen()});
  }
}
