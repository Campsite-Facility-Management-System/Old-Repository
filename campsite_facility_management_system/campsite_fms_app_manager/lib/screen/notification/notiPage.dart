import 'package:flutter/material.dart';

class NotiPageScreen extends StatefulWidget {
  @override
  NotiPageScreenState createState() => NotiPageScreenState();
}

class NotiPageScreenState extends State<NotiPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Text("알림"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
