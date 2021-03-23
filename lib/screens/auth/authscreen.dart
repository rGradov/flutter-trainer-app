import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workout_app/const/const.dart';
import 'package:workout_app/screens/home/homescreen.dart';
import 'package:http/http.dart' as http;

class User {
  final String email;
  final String password;

  User({this.email, this.password});
}

Future<User> postData(String email, String password) async {
  final resp = await http.post(
    Uri.http(ApiLogin, 'typicode/demo/posts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': email,
    }),
  );
  if (resp.statusCode == 201) {
  } else {
    throw Exception('Failed to login.');
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pswdController = TextEditingController();
  String email;
  String pswd;

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Container(
          child: Align(
            child: Text(
              'FIT',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      );
    }

    Widget _input(
        Icon icon, String hint, TextEditingController controller, bool secure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: secure,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white30),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MainColor, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MainColor30, width: 1)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: icon,
                ),
              )),
        ),
      );
    }

    Widget _button(void func()) {
      return RaisedButton(
        splashColor: Colors.white,
        highlightColor: Colors.white,
        color: MainColor,
        child: Text('login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            )),
        onPressed: () {
          email = _emailController.text;
          pswd = _pswdController.text;
          _emailController.clear();
          _pswdController.clear();
          postData(email, pswd);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomeScreen()),
          // );
        },
      );
    }

    Widget _form(String lable, void func()) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _input(
                    Icon(Icons.email), "email", _emailController, false)),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: _input(Icon(Icons.lock), "pswd", _pswdController, true),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(() {}),
              ),
            )
          ],
        ),
      );
    }

    void _loginFunc() {
      email = _emailController.text;
      pswd = _pswdController.text;
      _emailController.clear();
      _pswdController.clear();
      postData(email, pswd);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[_logo(), _form('login', _loginFunc)],
        ),
      ),
    );
  }
}
