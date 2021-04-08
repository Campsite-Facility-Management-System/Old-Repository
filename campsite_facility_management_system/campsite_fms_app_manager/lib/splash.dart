import 'package:flutter/material.dart';
import 'dart:async';
import 'package:campsite_fms_app_manager/function/mainFunction.dart';
import 'package:campsite_fms_app_manager/token.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final token = new Token();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushNamed(context, nextPage());
    });
    super.initState();
  }

  void navigationPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => MainFunction()));
  }

  nextPage() async {
    var tokenStatus = await token.tokenTest();
    if (tokenStatus) {
      Navigator.pushNamed(context, '/signIn');
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
