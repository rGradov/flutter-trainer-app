import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:workout_app/const/const.dart';
import 'package:workout_app/models/user-reg.dart';
import 'package:workout_app/screens/home/homescreen.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Container(
          child: Align(
            child: Text(
              LoginPageMainText,
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
                hintText: 'pswd',
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
              RequiredValidator(errorText: "* Required"),
              MinLengthValidator(6,
                  errorText: "Password should be atleast 6 characters"),
              MaxLengthValidator(15,
                  errorText:
                      "Password should not be greater than 15 characters")
            ])),
      );
    }

    Widget _inputName() {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          controller: _nameController,
          obscureText: false,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white30),
              hintText: 'name',
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
            RequiredValidator(errorText: "* Required"),
            MinLengthValidator(6,
                errorText: "Name should be atleast 6 characters"),
            MaxLengthValidator(15,
                errorText: "Name should not be greater than 15 characters")
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
                hintText: 'email',
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
              RequiredValidator(errorText: "* Required"),
              EmailValidator(errorText: "Enter valid email id"),
            ]),
          ));
    }

    Widget _switch() {
      return SwitchListTile(
        title: Text(
          'trainer?',
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

    Widget _button(void func()) {
      return RaisedButton(
        splashColor: Colors.white,
        highlightColor: Colors.white,
        color: MainColor,
        child: Text('Register',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            )),
        onPressed: () {
          if (formkey.currentState.validate()) {
            postData(_emailController.text, _pswdController.text);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );

            formkey.currentState.reset();
          }
        },
      );
    }

    Widget _form(String lable) {
      return Form(
        autovalidate: true,
        key: formkey,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _inputName()),
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
          children: <Widget>[
            _logo(),
            _form(
              'register',
            )
          ],
        ),
      ),
    );
  }
}
