import 'package:flutter/material.dart';

class CtrlPageScreen extends StatefulWidget {
  @override
  CtrlPageScreenState createState() => CtrlPageScreenState();
}

class CtrlPageScreenState extends State<CtrlPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Text("제어 페이지"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
