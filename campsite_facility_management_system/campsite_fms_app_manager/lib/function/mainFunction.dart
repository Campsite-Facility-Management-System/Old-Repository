import 'package:campsite_fms_app_manager/sign/login.dart';
import 'package:campsite_fms_app_manager/sign/signUp.dart';
import 'package:flutter/material.dart';

class MainFunction extends StatefulWidget {
  @override
  _MainFunctionState createState() => _MainFunctionState();
}

class _MainFunctionState extends State<MainFunction> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: [
          LoginScreen(),
          LoginScreen(),
          SignUpScreen(),
          SignUpScreen()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                setState(() {
                  currentPage = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.control_camera),
              onPressed: () {
                setState(() {
                  currentPage = 1;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.notification_important),
              onPressed: () {
                setState(() {
                  currentPage = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.more),
              onPressed: () {
                setState(() {
                  currentPage = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
