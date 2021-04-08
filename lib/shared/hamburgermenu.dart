import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/const/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:workout_app/route/routerName.dart';
import 'package:http/http.dart' as http;

import 'package:workout_app/screens/auth/authscreen.dart';

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

Future postData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String token = sharedPreferences.getString("token");

  print(token);
  final resp = await http.get(
    Uri.http(ApiUrl, 'api/user'),
    headers: <String, String>{
      HttpHeaders.authorizationHeader: "Bearer ${token}"
    },
  );
  print('Response status: ${resp.statusCode}');
  print('Response body: ${resp.body}');
  var jsonResponse = null;
  jsonResponse = json.decode(resp.body);
  print(jsonResponse);
  return jsonResponse;
}

class HamburgerMenu extends StatefulWidget {
  @override
  _HamburgerMenuState createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends State<HamburgerMenu> {
  String firstName = '';
  String lastName = '';
  String email;
  bool _trainer = false;

  @override
  void initState() {
    getData().then((value) => {
          print(value),
          setState(() {
            email = value['email'];
            _trainer = value['trainer'];
            firstName = value['firstname'];
            lastName = value['lastname'];
          }),
          print(_trainer)
        });

    print(email);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          // padding: EdgeInsets.zero,
          children: [
            // if( _trainer == true)
            DrawerHeader(
              child: Text("${firstName} ${lastName}"),
              // child: Text("${email}"),
              decoration: BoxDecoration(
                color: MainColor,
              ),
            ),

            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: MainColor,
              ),
              title: Text(
                "menu-profile".tr().toString(),
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => {
                Navigator.pushNamed(context, ProfileRoute),
              },
            ),
            if (_trainer == true)
              ListTile(
                leading: Icon(
                  Icons.supervisor_account,
                  color: MainColor,
                ),
                title: Text(
                  "menu-invite".tr().toString(),
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pushNamed(context, InviteRoute);
                },
              ),
                 if(_trainer == false)
            ListTile(
              leading: Icon(
                Icons.notifications,
                color: MainColor,
              ),
           
              title: Text(
                "menu-nontific".tr().toString(),
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, NontificationRoute);
              },
            ),
            ListTile(
                leading: Icon(
                  Icons.exit_to_app_sharp,
                  color: MainColor,
                ),
                title: Text(
                  'menu-logout'.tr().toString(),
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.remove('token');
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginRoute, (r) => false);
                }),
          ],
        ),
      ),
    );
  }
}
