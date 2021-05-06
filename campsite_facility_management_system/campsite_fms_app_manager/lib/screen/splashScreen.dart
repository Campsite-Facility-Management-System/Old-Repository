import 'package:campsite_fms_app_manager/function/token.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:campsite_fms_app_manager/function/mainFunction.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final token = new Token();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      nextPage();
    });
    super.initState();
  }

  nextPage() async {
    var tokenStatus = await token.tokenTest();
    print('tokenstatus: ' + tokenStatus.toString());
    if (tokenStatus) {
      Navigator.pushNamed(context, '/mainFunction');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        child: Center(
          child: Lottie.network(
            'https://assets3.lottiefiles.com/packages/lf20_mb3hpfox.json',
          ),
        ),
      ),
    );
  }
}
