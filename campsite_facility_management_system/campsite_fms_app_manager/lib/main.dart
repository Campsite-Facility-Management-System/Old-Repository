import 'package:campsite_fms_app_manager/function/searchFunction.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:campsite_fms_app_manager/screen/homePage/addCampScreen.dart';
import 'package:campsite_fms_app_manager/screen/homePage/addCategoryScreen.dart';
import 'package:campsite_fms_app_manager/screen/homePage/addDeviceScreen.dart';
import 'package:campsite_fms_app_manager/screen/homePage/campDetailScreen.dart';
import 'package:campsite_fms_app_manager/screen/homePage/homePageScreen.dart';
import 'package:campsite_fms_app_manager/screen/more/morePageScreen.dart';
import 'package:campsite_fms_app_manager/screen/notification/notiPageScreen.dart';
import 'package:campsite_fms_app_manager/screen/sign/loginScreen.dart';
import 'package:campsite_fms_app_manager/screen/sign/signUpScreen.dart';
import 'package:campsite_fms_app_manager/screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:campsite_fms_app_manager/function/mainFunction.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<IdCollector>(
      create: (context) => IdCollector(),
      child: MyApp(),
    ),
  );
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
        '/notiPage': (context) => NotiPageScreen(),
        '/morePage': (context) => MorePageScreen(),
        '/homePage': (context) => HomePageScreen(),
        '/addCamp': (context) => AddCampScreen(),
        '/addDevice': (context) => AddDeviceScreen(),
        '/addCategory': (context) => AddCategoryScreen(),
        '/campDetail': (context) => CampDetailScreen(),
      },
    );
  }
}
