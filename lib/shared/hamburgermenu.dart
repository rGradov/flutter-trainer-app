import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/const/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:workout_app/route/routerName.dart';
import 'package:http/http.dart' as http;

import 'package:workout_app/screens/auth/authscreen.dart';

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
  print(jsonResponse['username']);
  return jsonResponse;
  // if (resp.statusCode == 200) {
  //   return 'true';
  // } else {
  //   return resp.body;
  // }
}


class HamburgerMenu extends StatefulWidget {
  @override
  _HamburgerMenuState createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends State<HamburgerMenu> {
  String firstName;
  String lastName;

  @override
  void initState() {
    postData().then((value) => {
          setState(() {
            firstName = value['firstname'];
            lastName = value['lastname'];
          })
        });

    print(firstName);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          // padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("${firstName} ${lastName}"),
              decoration: BoxDecoration(
                color: MainColor,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: MainColor,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onTap:()async{
                  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove('token');
  Navigator.pushNamedAndRemoveUntil(context, LoginRoute, (r) => false);
}
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.account_circle,
            //     color: MainColor,
            //   ),
            //   title: Text(
            //     "login-btn-text".tr().toString(),
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onTap: () => {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => AuthScreen(),
            //         ))
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
