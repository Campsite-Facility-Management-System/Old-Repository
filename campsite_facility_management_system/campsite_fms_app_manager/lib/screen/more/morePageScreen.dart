import 'package:flutter/material.dart';

class MorePageScreen extends StatefulWidget {
  @override
  MorePageScreenState createState() => MorePageScreenState();
}

class MorePageScreenState extends State<MorePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Text("더보기"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
