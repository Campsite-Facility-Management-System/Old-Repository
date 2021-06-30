import 'package:campsite_fms_app_user/screen/homePage/campDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:campsite_fms_app_user/screen/sign/loginScreen.dart';
import 'package:campsite_fms_app_user/screen/sign/signUpScreen.dart';
import 'package:campsite_fms_app_user/screen/homePage/HomePage.dart';
import 'package:campsite_fms_app_user/function/categoryList.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: '모닥모닥',
        debugShowCheckedModeBanner: false, //debug ribbon remove
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/signIn': (context) => SignUpScreen(),
          '/homePage': (context) => HomePage(),
          // '/campDetail': (context) => CampDetailScreen(),
        });
  }
}
