import 'package:flutter/material.dart';
import 'package:campsite_fms_app_manager/env.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => new _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = new TextEditingController();
  TextEditingController _passwd = new TextEditingController();
  TextEditingController _nickName = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _phone = new TextEditingController();

  _signUp(String email, String passwd, String nickName, String name,
      String phone) async {
    if (_formKey.currentState.validate()) {
      var url = Env.url + '/api/auth/manager/register';
      var response = await http.post(url, body: {
        'email': email,
        'password': passwd,
        'nick_name': nickName,
        'name': name,
        'phone_number': phone,
      });

      print('email : ' + email);
      print('passwd : ' + passwd);
      print('name : ' + name);
      print('nickName : ' + nickName);
      print('phone : ' + phone);
      print(response.headers);
      print(response.body);
      print(response.statusCode);
      Navigator.pop(context);
    }
  }

  String _validateConfirm(String input) {
    if (input != _passwd.text) {
      return '비밀번호가 일치하지 않습니다';
    } else {
      return null;
    }
  }

  String _validateEmail(String input) {
    RegExp regex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return !regex.hasMatch(input) ? '     not Email Form' : null;
  }

  String _validatePasswd(String input) {
    RegExp regex = new RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$');
    return !regex.hasMatch(input)
        ? '     최소 8자리이상, 숫자문자 특수문자 각각1개이상 포함해야됩니다.'
        : null;
  }

  String _validateName(String input) {
    RegExp regex = new RegExp(r'^[가-힣]{2,4}$');
    return !regex.hasMatch(input) ? '     한글 이름이 필요합니다' : null;
  }

  //닉네임 중복검사 필요
  String _validateNickName(String input) {
    RegExp regex = new RegExp(r'^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣0-9|a-z|A-Z]{2,6}$');
    return !regex.hasMatch(input) ? '     2~8자의 한글, 영문, 숫자만 사용할 수 있습니다.' : null;
  }

  String _validatePhone(String input) {
    RegExp regex = new RegExp(r'^01{1}[016789]{1}[0-9]{8}');
    return !regex.hasMatch(input) ? '     not Phone Number' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100),
                Text(
                  '회원가입',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Text('Email'),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Email"),
                  controller: _email,
                  validator: (input) => _validateEmail(input),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Text('Password'),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Password"),
                  controller: _passwd,
                  validator: (input) => _validatePasswd(input),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Text('Password confirm'),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password Confirm"),
                  validator: (input) => _validateConfirm(input),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Text('NickName'),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "NickName"),
                  controller: _nickName,
                  validator: (input) => _validateNickName(input),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Text('Name'),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Name"),
                  controller: _name,
                  validator: (input) => _validateName(input),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Text('Phone Number'),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Phone number"),
                  controller: _phone,
                  validator: (input) => _validatePhone(input),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => _signUp(
                        _email.text,
                        _passwd.text,
                        _nickName.text,
                        _name.text,
                        _phone.text,
                      ),
                      child: Text('확인'),
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
