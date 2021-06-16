import 'package:campsite_fms_app_manager/model/electric/electricGraph.dart';
import 'package:campsite_fms_app_manager/model/electric/electricInfo.dart';
import 'package:campsite_fms_app_manager/model/electric/graphData.dart';
import 'package:campsite_fms_app_manager/model/electric/usageData.dart';
import 'package:campsite_fms_app_manager/provider/idCollector.dart';
import 'package:campsite_fms_app_manager/screen/electric/electricScreen.dart';
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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IdCollector()),
        ChangeNotifierProvider(
          create: (_) => UsageData(0, 0),
        ),
        ChangeNotifierProvider(
          create: (_) => GraphData(0, 0),
        ),
      ],
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
      initialRoute: '/login',
      routes: {
        // '/': (context) => SplashScreen(),
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
        '/electricInfo': (context) => ElectricInfo(),
        '/electricGraph': (context) => ElectricGraph(),
        '/electricScreen': (contetx) => ElectricScreen(),
      },
    );
  }
}
