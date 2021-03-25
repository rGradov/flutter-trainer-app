import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:workout_app/const/const.dart';
import 'package:workout_app/screens/auth/register/registerscreen.dart';
import 'package:workout_app/screens/home/homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      'email': email,
      'password': password,
    }),
  );
  if (resp.statusCode == 201) {
  } else {}
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

List languageCode = ["en", "ru"];
List countryCode = ["US", "RU"];

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool _isLoggedIn = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pswdController = TextEditingController();

  var userTrainer = new User();

  static String userEmail = 'trainer@gmail.com';
  static String userPswd = 'trainer';

  _login() async {
    print('try login');
    try {
      await _googleSignIn.signIn().then((value) => {
            if (_isLoggedIn = true)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                )
              }
          });
      setState(() {
        _isLoggedIn = true;
      });
      print(_googleSignIn.currentUser.email);

      print('login');
    } catch (err) {
      print('errors:');
      print(err);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Container(
          child: Align(
            child: Text(
              "main-title".tr().toString(),
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      );
    }

    Widget _inputPswd() {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
            controller: _pswdController,
            obscureText: false,
            style: TextStyle(fontSize: 20, color: Colors.white),
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white30),
                hintText: "hint-pswd".tr().toString(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MainColor, width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MainColor30, width: 1)),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: Icon(Icons.lock),
                  ),
                )),
            validator: MultiValidator([
              RequiredValidator(errorText: "erorr-req".tr().toString()),
              MinLengthValidator(6,
                  errorText: "pswd-error-min-length".tr().toString()),
              MaxLengthValidator(15,
                  errorText: "pswd-error-max-length".tr().toString())
            ])),
      );
    }

    Widget _inputEmail() {
      return Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            controller: _emailController,
            obscureText: false,
            style: TextStyle(fontSize: 20, color: Colors.white),
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white30),
                hintText: "hint-email".tr().toString(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MainColor, width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MainColor30, width: 1)),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: Icon(Icons.email),
                  ),
                )),
            validator: MultiValidator([
              RequiredValidator(errorText: "erorr-req".tr().toString()),
              EmailValidator(errorText: "error-valid-email".tr().toString()),
            ]),
          ));
    }

    Widget _btnSigIn(void func()) {
      return OutlineButton.icon(
          splashColor: Colors.white,
          highlightColor: Colors.white,
          focusColor: Colors.greenAccent,
          borderSide: BorderSide(
            color: MainColor30,
          ),
          color: MainColor,
          label: Text(
            "btn-google-signIn".tr().toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
          ),
          icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
          onPressed: () {
            _logout();
            _login();
          });
    }

    Widget _button(void func()) {
      return RaisedButton(
        splashColor: Colors.white,
        highlightColor: Colors.white,
        color: MainColor,
        child: Text("${"login-btn-text".tr().toString()}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            )),
        onPressed: () {
          if (formkey.currentState.validate()) {
            postData(_emailController.text, _pswdController.text);
            if (_emailController.text == userEmail) {
              print('correct email');
              if (_pswdController.text == userPswd) {
                print('work');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                formkey.currentState.reset();
              } else {
                final snackBar = SnackBar(
                  content: Text("valid-pswd".tr().toString()),
                  action: SnackBarAction(
                    label: 'ok',
                    onPressed: () {
                      // formkey.currentState.reset();
                      _pswdController.clear();
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              final snackBar = SnackBar(
                content: Text("valid-email".tr().toString()),
                action: SnackBarAction(
                  label: 'ok',
                  onPressed: () {
                    formkey.currentState.reset();
                  },
                ),
              );

              // Find the ScaffoldMessenger in the widget tree
              // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
      );
    }

    Widget _form(String lable) {
      return Form(
        // autovalidate: true,
        key: formkey,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _inputEmail()),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: _inputPswd(),
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
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(
                Icons.g_translate,
                color: Colors.white,
              ),
              onPressed: () {
                print(context.locale);
                if (context.locale.toString() == 'en_US') {
                  context.locale = Locale("ru", "RU");
                } else {
                  context.locale = Locale('en', 'US');
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            _logo(),
            _form(
              'login',
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _btnSigIn(() {}),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                child: Text(
                  "not-reg-btn".tr().toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
