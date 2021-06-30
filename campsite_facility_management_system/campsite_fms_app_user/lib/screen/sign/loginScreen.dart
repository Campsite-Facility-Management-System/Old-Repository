import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:campsite_fms_app_user/function/token/tokenFunction.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:campsite_fms_app_user/env.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:campsite_fms_app_user/screen/homePage/HomePage.dart';
import 'package:campsite_fms_app_user/function/token/tokenFunction.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _passwd = new TextEditingController();
  final token = new FlutterSecureStorage();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  static DateTime pressBack;
  final tokenFunction = new TokenFunction();

  _check() async {
    bool result = await tokenFunction.tokenCheck(context);
    // print('tokenstatus: ' + tokenStatus.toString());
    if (result == true) {
      Navigator.pushNamed(context, '/homePage');
    }
  }

  _login(String email, String passwd) async {
    bool result = await tokenFunction.tokenCreate(email, passwd);
    if (result) {
      Navigator.pushNamed(context, '/homePage');
    }
  }

  _end() {
    DateTime now = DateTime.now();
    if (pressBack == null || now.difference(pressBack) > Duration(seconds: 2)) {
      pressBack = now;
      _globalKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('한번 더 누르면 앱을 종료합니다'),
            duration: Duration(seconds: 2),
          ),
        );
      return false;
    } else {
      SystemNavigator.pop();
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool result = _end();
        return await Future.value(result);
      },
      child: Scaffold(
        key: _globalKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Container(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 100),
                  SizedBox(
                      height: 300,
                      width: 300,
                      child: Image.asset('icon/color-brown copy.jpg')),
                  SizedBox(height: 10),
                  Text(
                    'MODAK MODAK',
                    style: TextStyle(
                      fontFamily: 'HN',
                      color: Colors.brown,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //       Text(
                  //         'Email',
                  //         style: TextStyle(
                  //           color: Colors.brown,
                  //         ),
                  //       ),
                  //     ]),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'ID',
                        // contentPadding:
                        //     EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                      controller: _email,
                    ),
                  ),

                  SizedBox(height: 20),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //       Text('Password',
                  //           style: TextStyle(
                  //             color: Colors.brown,
                  //           )),
                  //     ]),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Password'),
                      obscureText: true,
                      controller: _passwd,
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Color(0xFF00A963),
                      onPressed: () => _login(_email.text, _passwd.text),
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: TextButton(
                      // color: Color(0xFFFFFFFF),
                      onPressed: () => Navigator.pushNamed(context, '/signIn'),
                      child: Text(
                        '회원가입',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     // RaisedButton(
                  //     //   onPressed: null,
                  //     //   child: Text('아이디/비밀번호 찾기'),
                  //     // ),
                  //     // SizedBox(width: 30),
                  //     RaisedButton(
                  //       color: Color(0xFF00A963),
                  //       onPressed: () =>
                  //           Navigator.pushNamed(context, '/signIn'),
                  //       child: Text(
                  //         '회원가입',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// void flutterToast() async {
//   try {
//     Fluttertoast.showToast(
//       msg: '로그인 실패',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       textColor: Colors.white,
//     );
//   } catch (e) {
//     debugPrint(e);
//   }
// }
