import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:campsite_fms_app_manager/env.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _passwd = new TextEditingController();
  final token = new FlutterSecureStorage();

  _login(String email, String passwd) async {
    var url = Env.url + '/api/auth/login';
    var response = await http.post(url, body: {
      'password': passwd,
      'email': email,
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> list = jsonDecode(response.body);
      await token.write(key: 'token', value: list['access_token']);
      // print(email);
      // print(passwd);
      // print(response.statusCode);
      // print(list);
      // print(response.body);
      var a = await token.read(key: 'token');
      // print("aaa");
      // print(a);
      Navigator.pushNamed(context, '/homePage');
    } else if (response.statusCode == 401) {
      // print("login error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Container(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 200),
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ]),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'ID'),
                  controller: _email,
                ),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Password',
                          style: TextStyle(
                            color: Colors.blue,
                          )),
                    ]),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Password'),
                  obscureText: true,
                  controller: _passwd,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: RaisedButton(
                    onPressed: () => _login(_email.text, _passwd.text),
                    child: Text('로그인'),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: null,
                      child: Text('아이디/비밀번호 찾기'),
                    ),
                    SizedBox(width: 30),
                    RaisedButton(
                      onPressed: () => Navigator.pushNamed(context, '/signIn'),
                      child: Text('회원가입'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
