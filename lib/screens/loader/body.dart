import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/const/const.dart';
import 'package:workout_app/route/routerName.dart';

Future getUserData() async {
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
  sharedPreferences.setString("email", jsonResponse['email']);
  sharedPreferences.setString("firstname", jsonResponse['firstname']);
  sharedPreferences.setString("lastname", jsonResponse['lastname']);
  sharedPreferences.setBool("trainer", jsonResponse['trainer']);
  sharedPreferences.setString(
      "registrationdate", jsonResponse['registrationdate']);
  sharedPreferences.setBool("active", jsonResponse['active']);
  sharedPreferences.setBool("confirmed", jsonResponse['confirmed']);
  sharedPreferences.setBool("delete", jsonResponse['delete']);

  // sharedPreferences.setStringList('invitesFrom', jsonResponse['invitesFrom']);
  // print('if:' + jsonResponse['invitesFrom']);
  // }

  return jsonResponse;
}

class LoaderBody extends StatefulWidget {
  @override
  _LoaderBodyState createState() => _LoaderBodyState();
}

class _LoaderBodyState extends State<LoaderBody> {
  String email;
  String username;
  String firstname;
  String lastname;
  bool trainer;
  String registrationdate;
  bool active;
  bool confirmed;
  bool delete;

  void initState() {
    getUserData().then((value) => {
          print('done'),
          Navigator.pushNamedAndRemoveUntil(context, HomeRoute, (r) => false)
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Center(
              child: Text(
                'fetch data',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
