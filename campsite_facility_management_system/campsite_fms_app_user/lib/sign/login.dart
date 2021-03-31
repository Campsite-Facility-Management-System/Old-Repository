import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController passwd = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.blue,
        body: Column(children: <Widget>[
      Container(
          //height: double.infinity,
          //width: double.infinity,
          //decoration: BoxDecoration(color: Colors.blue),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),

                Container(), // illust
                Container(
                  child: Text('Sign In',
                      style: TextStyle(
                        color: Color(0xFF73AEF5),
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      )),
                ), // text

                SizedBox(
                  height: 50,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ' Email',
                      textAlign: TextAlign.left,
                    ),

                    SizedBox(
                      height: 5,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '  Email',
                        ),
                      ),
                    ), // id box

                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      ' Password',
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: passwd,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '  10자리 이상, 영어, 숫자, 특수문자로 구성'),
                      ),
                    ), // pw box
                  ],
                ),

                SizedBox(
                  height: 50,
                ),

                Container(
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Color(0xFF527DAA),
                      child: Text('Log In'),
                      onPressed: null,
                    )),

                // SizedBox(),

                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text('sign up', textAlign: TextAlign.center),
                        onPressed: () => print(email.text),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text('forgot id/password?',
                            textAlign: TextAlign.center),
                        onPressed: () => print(passwd.text),
                      )
                    ]) // signin find pw
              ]))
    ]));
  }
}
