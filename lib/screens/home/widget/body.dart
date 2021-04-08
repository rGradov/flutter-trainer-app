import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/const/const.dart';
import 'package:workout_app/route/routerName.dart';
import 'package:workout_app/screens/timetable/timetablescreen.dart';

Future falseInvite(String name, bool accept) async {
  print(name);
  String trainer = name;
  bool st = accept;
  print('status:${st}');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String token = sharedPreferences.getString("token");
  final resp = await http.put(
    Uri.http(ApiUrl, 'api/invite/action'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer ${token}",
    },
    body: jsonEncode({'username': trainer, 'accept': false}),
  );
  print('Response status: ${resp.statusCode}');
  print('Response body: ${resp.body}');
  return resp.statusCode;
}

Future invite(String name, bool accept) async {
  print(name);
  String trainer = name;
  bool st = accept;
  print('status:${st}');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String token = sharedPreferences.getString("token");
  final resp = await http.put(
    Uri.http(ApiUrl, 'api/invite/action'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer ${token}",
    },
    body: jsonEncode({'username': trainer, 'accept': true}),
  );

  print('Response status: ${resp.statusCode}');
  print('Response body: ${resp.body}');
  return resp.statusCode;
}

Future<void> _showMyDialog(context, trainerName) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Приглашение'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                  'Тренер ${trainerName} приглашает принять вас участие в тренировке'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () async {
              final code = await falseInvite(trainerName, false);
              if (code == 200) {
                // Navigator.pop(context);
                Navigator.pop(context);
              }
            },
          ),
          TextButton(
              child: Text('Approve'),
              onPressed: () async {
                final code = await invite(trainerName, true);
                print(code);
                if (code == 200) {
                  print(code);
                  Navigator.pop(context);
                }
              }),
        ],
      );
    },
  );
}

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final invites = ['test'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MainText(),
    );
  }
}

class MainText extends StatelessWidget {
  const MainText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          new Expanded(
            child: Column(),
            flex: 1,
          ),
          new Expanded(
            child: Column(
                //mainAxisAlignment:MainAxisAlignment.,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Navigations()]),
            flex: 2,
          )
        ],
      ),
    );
  }
}

class HeaderTxt extends StatelessWidget {
  const HeaderTxt({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   "trainer".tr().toString(),
        //   // text
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     color: MainColor,
        //     fontSize: 40,
        //     fontWeight: FontWeight.w400,
        //     decoration: TextDecoration.underline,
        //   ),
        // ),
      ],
    );
  }
}

class Navigations extends StatelessWidget {
  const Navigations({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.white,
      fontSize: 35,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                alignment: FractionalOffset.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: GestureDetector(
                    child: Text(
                      "payment".tr().toString(),
                      textAlign: TextAlign.left,
                      style: textStyle,
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            alignment: FractionalOffset.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                child: Text("timetable".tr().toString(),
                    textAlign: TextAlign.left, style: textStyle),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimetableScreen()),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            alignment: FractionalOffset.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                child: Text("workouts".tr().toString(),
                    textAlign: TextAlign.left, style: textStyle),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => TimetableScreen()),
                  // );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            alignment: FractionalOffset.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                child: Text("statistics".tr().toString(),
                    textAlign: TextAlign.left, style: textStyle),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => TimetableScreen()),
                  // );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
