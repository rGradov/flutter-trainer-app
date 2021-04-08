import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/const/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

Future<String> _updateEmail(String email) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String token = sharedPreferences.getString("token");
  final resp = await http.put(
    Uri.http(ApiUrl, '/api/email/change'),
    headers: <String, String>{
      HttpHeaders.authorizationHeader: "Bearer ${token}"
    },
    body: jsonEncode(<String, String>{
      'email': email.toString(),
    }),
  );
  print(resp.statusCode);
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

Future getData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String email = sharedPreferences.getString("email");
  final bool trainer = sharedPreferences.getBool("trainer");
  final String lastname = sharedPreferences.getString("lastname");
  final String firstname = sharedPreferences.getString("firstname");
  var map = {
    'email': email,
    'trainer': trainer,
    'lastname': lastname,
    'firstname': firstname,
  };
  return map;
}

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String firstName;
  String lastName;
  String email;

  @override
  void initState() {
    getData().then((value) => {
          print(value),
          setState(() {
            // email = value['email'];
            firstName = value['firstname'];
            lastName = value['lastname'];
            displayEmailController.text = value['email'];
          }),
        });

    print(email);
    super.initState();
  }

  var status = true;
  TextEditingController displayEmailController = TextEditingController();

  Widget _ProgressButton() {
    return ProgressButton(
        defaultWidget: Text("reg-btn-text".tr().toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            )),
        color: MainColor,
        progressWidget: const CircularProgressIndicator(
          backgroundColor: Colors.black,

          // valueColor: ,
        ),
        animate: true,
        // type: ProgressButtonType.Flat,
        onPressed: () async {
          if (true) {
            if (status == true) {
              setState(() {
                status = !status;
              });
              final body = await _updateEmail(displayEmailController.text);
              print(body);
              if (body == 'true') {
                setState(() {
                  status = !status;
                });
              } else {
                setState(() {
                  status = !status;
                });
                final snackBar = SnackBar(
                  content: Text(body.toString().tr().toString()),
                  action: SnackBarAction(
                    label: 'ok'.tr().toString(),
                    onPressed: () {},
                    // formkey.currentState.reset();
                    // _pswdController.clear();
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              print('press');
            }
          }
        });
  }

  Widget buildDisplayNameField() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 12.0, bottom: 10),
              child: Text(
                "Display Email",
                style: TextStyle(color: Colors.white),
              )),
          TextFormField(
              controller: displayEmailController,
              style: TextStyle(fontSize: 20, color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MainColor, width: 3),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: MainColor30, width: 1),
                ),
                hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white30),
                hintText: "hint-email".tr().toString(),
                icon: Padding(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: IconTheme(
                      data: IconThemeData(color: MainColor),
                      child: Icon(Icons.email)),
                ),
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: "erorr-req".tr().toString()),
                MinLengthValidator(6,
                    errorText: "pswd-error-min-length".tr().toString()),
                MaxLengthValidator(15,
                    errorText: "pswd-error-max-length".tr().toString())
              ])),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildDisplayNameField(),
          _ProgressButton(),
        ],
      ),
    );
  }
}
