import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:campsite_fms_app_manager/env.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class TokenFunction {
  final token = new FlutterSecureStorage();

  Future<bool> tokenCheck(context) async {
    // print("토큰 체크");

    var url = Env.url + '/api/auth/check';
    String value = await token.read(key: 'token');
    String myToken = "Bearer" + value.toString();

    if (value != null) {
<<<<<<< Updated upstream
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': myToken,
      });
      // print(response.body);
=======
      var response = await http.post(url, headers: {
        'Authorization': myToken,
      });
>>>>>>> Stashed changes
      var data = jsonDecode(response.body);
      // print('tokenCheck(myToken): ' + myToken);
      // print('tokenCheck(response.body): ' + response.body);
      // print('tokenCheck(status): ' + data['status']);
      // print('tokenCheck(status): ' + data['error']);

      if (data['status'] == 'success') {
        // print("성공");
        return true;
      } else {
        tokenDelete(context);
      }
    } else {
      return false;
    }

    // else if (data['error'] == 'Expired') {
    //   print("만료");
    //   return tokenRefresh(context);
    // } else if (data['error'] == 'Invalid') {
    //   print("tokenCheck error: Invalid");
    // } else if (data['error'] == 'Unknown') {
    //   print("tokenCheck error: Unknown");
    // }
    return false;
  }

<<<<<<< Updated upstream
  // Future<bool> tokenRefresh(context) async {
  //   var url = Env.url + '/api/auth/refresh';
  //   String value = await token.read(key: 'token');
  //   String myToken = "Bearer" + value.toString();

  //   var refresh = await http.post(url, headers: {
  //     'Authorization': myToken,
  //   });
  //   // print('refresh' + refresh.body.toString());

  //   if (refresh.statusCode == 200) {
  //     Map<String, dynamic> result = jsonDecode(refresh.body);
  //     await token.write(key: 'token', value: result['access_token']);
  //     // print("tokenRefresh success");
  //   } else {
  //     tokenDelete(context);
  //   }
  //   return true;
  // }
=======
  Future<bool> tokenRefresh(context) async {
    var url = Env.url + '/api/auth/refresh';
    String value = await token.read(key: 'token');
    String myToken = "Bearer" + value.toString();

    var refresh = await http.post(url, headers: {
      'Authorization': myToken,
    });
    // print('refresh' + refresh.body.toString());

    if (refresh.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(refresh.body);
      await token.write(key: 'token', value: result['access_token']);
      // print("tokenRefresh success");
    } else {
      tokenDelete(context);
    }
    return true;
  }
>>>>>>> Stashed changes

  Future<bool> tokenCreate(String email, String passwd) async {
    print("tokenCreate run");
    var r = await token.read(key: 'token');
    print(r);
    var url = Env.url + '/api/auth/login';
<<<<<<< Updated upstream
    var response = await http.post(Uri.parse(url), body: {
=======
    var response = await http.post(url, body: {
>>>>>>> Stashed changes
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

  tokenDelete(context) async {
    token.deleteAll();
    Navigator.pushNamed(context, '/login');
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
