import 'package:campsite_fms_app_manager/env.dart';
import 'package:campsite_fms_app_manager/function/mainFunction.dart';
import 'package:campsite_fms_app_manager/screen/sign/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenGetX extends GetxController {
  final token = new FlutterSecureStorage();
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  static DateTime pressBack;
  final isLoginScreen = false;

  @override
  onInit() async {
    super.onInit();
    bool tokencheck = await tokenCheck();
    if (!tokencheck && !isLoginScreen) {
      Get.offAll(LoginScreen());
    }
  }

  tokenCheck() async {
    var url = Env.url + '/api/auth/check';
    String value = await token.read(key: 'token');
    String myToken = "Bearer" + value.toString();

    if (value != null) {
      var response = await http.post(url, headers: {
        'Authorization': myToken,
      });
      // print(response.body);
      var data = jsonDecode(response.body);
      // print('tokenCheck(myToken): ' + myToken);
      // print('tokenCheck(response.body): ' + response.body);
      // print('tokenCheck(status): ' + data['status']);
      // print('tokenCheck(status): ' + data['error']);

      if (data['status'] == 'success') {
        // print("성공");
        return true;
      } else {
        tokenDelete();
      }
    } else {
      return false;
    }
  }

  tokenCreate(String email, String passwd) async {
    print("tokenCreate run");
    var r = await token.read(key: 'token');
    print(r);
    var url = Env.url + '/api/auth/login';
    var response = await http.post(url, body: {
      'password': passwd,
      'email': email,
    });

    print("respone_body: " + response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> list = jsonDecode(response.body);
      await token.write(key: 'token', value: list['access_token']);
      return true;
    } else {
      // print("login error");
      flutterToast();
      return false;
    }
  }

  tokenDelete() async {
    await token.deleteAll();
    Get.offAll(LoginScreen());
  }

  login(String email, String passwd) async {
    bool result = await tokenCreate(email, passwd);
    if (result) {
      Get.to(MainFunction(0));
    }
  }

  logout() async {
    var url = Env.url + '/api/auth/logout';
    String value = await token.read(key: 'token');
    String myToken = "Bearer" + value.toString();

    var response = await http.post(url, headers: {
      'Authorization': myToken,
    });

    // print('tokenTest(myToken): ' + myToken);
    // print('tokenTest(response.body): ' + response.body);

    var data = jsonDecode(response.body);
    // print(data['status']);

    if (data['message'] == 'Successfully logged out') {
      tokenDelete();
    } else {
      print("logout error");
    }
  }

  end() {
    DateTime now = DateTime.now();
    if (pressBack == null || now.difference(pressBack) > Duration(seconds: 2)) {
      pressBack = now;
      globalKey.currentState
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

  void flutterToast() async {
    try {
      Fluttertoast.showToast(
        msg: '로그인 실패',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    } catch (e) {
      debugPrint(e);
    }
  }
}
