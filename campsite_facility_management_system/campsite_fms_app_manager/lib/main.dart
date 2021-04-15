import 'package:campsite_fms_app_manager/function/searchFunction.dart';
import 'package:campsite_fms_app_manager/screen/controll/ctrlPage.dart';
import 'package:campsite_fms_app_manager/screen/homePage/addCamp.dart';
import 'package:campsite_fms_app_manager/screen/homePage/homePage.dart';
import 'package:campsite_fms_app_manager/screen/more/morePage.dart';
import 'package:campsite_fms_app_manager/screen/notification/notiPage.dart';
import 'package:campsite_fms_app_manager/screen/sign/login.dart';
import 'package:campsite_fms_app_manager/screen/sign/signUp.dart';
import 'package:campsite_fms_app_manager/screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:campsite_fms_app_manager/function/mainFunction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '모닥모닥',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signIn': (context) => SignUpScreen(),
        '/mainFunction': (context) => MainFunction(),
        '/ctrlPage': (context) => CtrlPageScreen(),
        '/notiPage': (context) => NotiPageScreen(),
        '/morePage': (context) => MorePageScreen(),
        '/homePage': (context) => HomePageScreen(),
        '/addCamp': (context) => AddCampScreen(),
      },
    );
  }
}
