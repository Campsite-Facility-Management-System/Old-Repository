import 'package:campsite_fms_app_manager/screen/electric/electricScreen.dart';
import 'package:campsite_fms_app_manager/screen/homePage/homePageScreen.dart';
import 'package:campsite_fms_app_manager/screen/more/morePageScreen.dart';
import 'package:campsite_fms_app_manager/screen/notification/notiPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainFunction extends StatefulWidget {
  @override
  _MainFunctionState createState() => _MainFunctionState();
}

class _MainFunctionState extends State<MainFunction> {
  int currentPage = 0;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  static DateTime pressBack;

  _end(context) {
    DateTime now = DateTime.now();
    if (pressBack == null || now.difference(pressBack) > Duration(seconds: 2)) {
      pressBack = now;
      _globalKey.currentState;
      // ..hideCurrentSnackBar()
      _globalKey.currentState.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('한번 더 누르면 앱을 종료합니다'),
        duration: Duration(seconds: 2),
      ));

      return false;
    } else {
      SystemNavigator.pop();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool result = _end(context);
        return await Future.value(result);
      },
      child: Scaffold(
        key: _globalKey,
        body: IndexedStack(
          index: currentPage,
          children: [
            HomePageScreen(),
            ElectricScreen(),
            NotiPageScreen(),
            MorePageScreen(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                iconSize: 40,
                icon: Icon(
                  Icons.home,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    currentPage = 0;
                  });
                },
              ),
              IconButton(
                iconSize: 40,
                icon: Icon(
                  Icons.control_camera,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    currentPage = 1;
                  });
                },
              ),
              IconButton(
                iconSize: 40,
                icon: Icon(
                  Icons.notification_important,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    currentPage = 2;
                  });
                },
              ),
              IconButton(
                iconSize: 40,
                icon: Icon(
                  Icons.more,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    currentPage = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
