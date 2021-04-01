import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/const/const.dart';
import 'package:workout_app/route/routerName.dart';
import 'package:workout_app/screens/home/homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:workout_app/screens/auth/authscreen.dart';

class User {
  final String email;
  final String password;
  final String lastName;
  final String firstName;
  final String login;
  User({this.email, this.password, this.lastName, this.firstName, this.login});
}

Future<String> postData(String email, String password, String userName,
    String firstName, String lastName) async {
  // final prefs = await SharedPreferences.getInstance();
  // prefs.setString('email', email);
  // prefs.setString('pswd', password);
  final resp = await http.post(
    Uri.http(ApiUrl, 'api/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'username': userName,
      'firstname': firstName,
      'lastname': lastName,
      'password': password,
    }),
  );
  print('Response status: ${resp.statusCode}');
  print('Response body: ${resp.body}');
    var jsonResponse = null;
  if (resp.statusCode == 200) {
      jsonResponse = json.decode(resp.body);
    // print(jsonResponse['token']);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", jsonResponse.['token']);
    print(sharedPreferences.getString("token"));
    return 'true';
  } else {
    return resp.body;
  }
}

class RegScreen extends StatefulWidget {
  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final _user = User();
  var _trainer = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pswdController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();

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
            obscureText: true,
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

    Widget _inputFirstName() {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          controller: _firstNameController,
          obscureText: false,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white30),
              hintText: "hint-fname".tr().toString(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MainColor, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MainColor30, width: 1)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: Icon(Icons.account_circle),
                ),
              )),
          validator: MultiValidator([
            RequiredValidator(errorText: "erorr-req".tr().toString()),
            MinLengthValidator(2,
                errorText: "error-name-min-length".tr().toString()),
            MaxLengthValidator(15,
                errorText: "error-name-max-length".tr().toString())
          ]),
        ),
      );
    }

    Widget _inputLastName() {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          controller: _lastNameController,
          obscureText: false,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white30),
              hintText: "hint-lname".tr().toString(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MainColor, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MainColor30, width: 1)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: Icon(Icons.account_circle),
                ),
              )),
          validator: MultiValidator([
            RequiredValidator(errorText: "erorr-req".tr().toString()),
            MinLengthValidator(2,
                errorText: "error-name-min-length".tr().toString()),
            MaxLengthValidator(15,
                errorText: "error-name-max-length".tr().toString())
          ]),
        ),
      );
    }

    Widget _inputUserName() {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          controller: _userNameController,
          obscureText: false,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white30),
              hintText: "hint-name".tr().toString(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MainColor, width: 3),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MainColor30, width: 1)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: Icon(Icons.account_circle),
                ),
              )),
          validator: MultiValidator([
            RequiredValidator(errorText: "erorr-req".tr().toString()),
            MinLengthValidator(2,
                errorText: "error-name-min-length".tr().toString()),
            MaxLengthValidator(15,
                errorText: "error-name-max-length".tr().toString())
          ]),
        ),
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

    Widget _switch() {
      return SwitchListTile(
        title: Text(
          "${'trainer'.tr().toString()}?",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        value: _trainer,
        activeColor: MainColor,
        onChanged: (bool value) {
          setState(() => _trainer = value);
          print(_trainer);
        },
      );
    }

    void _clearForm() {
      formkey.currentState.reset();
      _pswdController.clear();
      _emailController.clear();
      _firstNameController.clear();
      _lastNameController.clear();
      _userNameController.clear();
    }

    Widget _button(void func()) {
      return RaisedButton(
        splashColor: Colors.white,
        highlightColor: Colors.white,
        color: MainColor,
        child: Text("reg-btn-text".tr().toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            )),
        onPressed: () async {
          if (formkey.currentState.validate()) {
            final body = await postData(
                _emailController.text,
                _pswdController.text,
                _userNameController.text,
                _firstNameController.text,
                _lastNameController.text);
            print(body);
            if (body == 'true') {
              _clearForm();
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeRoute, (r) => false);
            } else {
              final snackBar = SnackBar(
                content: Text(body.toString()),
                action: SnackBarAction(
                  label: 'ok',
                  onPressed: _clearForm,
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
                child: _inputUserName()),
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _inputFirstName()),
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _inputLastName()),
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _inputEmail()),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: _inputPswd(),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _switch()),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(() {}),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                child: Text(
                  "not-login-btn".tr().toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                },
              ),
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
          automaticallyImplyLeading: false,
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
              'register',
            ),
          ],
        ),
      ),
    );
  }
}
