import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/const/const.dart';
import 'package:workout_app/route/routerName.dart';
import 'package:workout_app/screens/auth/register/registerscreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_progress_button/flutter_progress_button.dart';

class User {
  final String email;
  final String password;
  User({this.email, this.password});
}

Future<String> postData(String email, String password) async {
  var status = await OneSignal.shared.getPermissionSubscriptionState();
  var userId = status.subscriptionStatus.userId;
  print(userId);
  final resp = await http.post(
    Uri.http(ApiUrl, 'api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'userId': userId,
    }),
  );
  print(resp.statusCode);
  // print(resp.body);
  var jsonResponse = null;
  if (resp.statusCode == 200) {
    jsonResponse = json.decode(resp.body);
    // print(jsonResponse['token']);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", jsonResponse['token']);

    print(sharedPreferences.getString("token"));
    return 'true';
  } else {
    return resp.body;
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

List languageCode = ["en", "ru"];
List countryCode = ["US", "RU"];

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pswdController = TextEditingController();
  bool isLoading = true;
  var status = true;
  bool _obscureText = true;

  var userTrainer = new User();

  static String userEmail = 'trainer@gmail.com';
  static String userPswd = 'trainer';

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
            obscureText: _obscureText,
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
              ),
              suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )),
            ),
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

    Widget _ProgressButton() {
      return ProgressButton(
        defaultWidget: Text(
          "${"login-btn-text".tr().toString()}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        color: MainColor,
        progressWidget: const CircularProgressIndicator(
          backgroundColor: Colors.black,

          // valueColor: ,
        ),
        animate: true,
        // type: ProgressButtonType.Flat,
        onPressed: () async {
          if (status == true) {
            if (formkey.currentState.validate()) {
              setState(() {
                status = !status;
              });
              print('disable');
              final body = await postData(
                _emailController.text,
                _pswdController.text,
              );
              print(body);
              if (body == 'true') {
                setState(() {
                  status = !status;
                });
                Navigator.pushNamedAndRemoveUntil(
                    context, LoaderRoute, (r) => false);
              } else {
                setState(() {
                  status = !status;
                });
                print(body.toString());

                final snackBar = SnackBar(
                  content: Text(body.toString().tr().toString()),
                  action: SnackBarAction(
                    label: 'Ok'.tr().toString(),
                    onPressed: () {
                      // formkey.currentState.reset();

                      if (body.toString() == 'Invalid password') {
                        _pswdController.clear();
                      } else {
                        _emailController.clear();
                        _pswdController.clear();
                      }
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
          } else {
            print('press');
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
                bottom: 15,
              ),
              child: _inputPswd(),
            ),
            SizedBox(
              height: 5,
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
          automaticallyImplyLeading: false,
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
                // width: MediaQuery.of(context).size.width,
                child: _ProgressButton(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      "not-reg-btn".tr().toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      _emailController.clear();
                      _pswdController.clear();
                      Navigator.pushNamed(
                        context,
                        RegisterRoute,
                      );
                    },
                  ),
                  GestureDetector(
                    child: Text(
                      "pswd-reset".tr().toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      _emailController.clear();
                      _pswdController.clear();
                      Navigator.pushNamed(
                        context,
                        ResetPswdRoute,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
