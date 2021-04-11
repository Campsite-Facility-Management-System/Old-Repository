import 'package:campsite_fms_app_manager/controll/ctrlPage.dart';
import 'package:campsite_fms_app_manager/function/searchFunction.dart';
import 'package:campsite_fms_app_manager/homePage/homePage.dart';
import 'package:campsite_fms_app_manager/more/morePage.dart';
import 'package:campsite_fms_app_manager/notification/notiPage.dart';
import 'package:campsite_fms_app_manager/sign/login.dart';
import 'package:campsite_fms_app_manager/sign/signUp.dart';
import 'package:campsite_fms_app_manager/splash.dart';
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
      },
    );
  }
}
