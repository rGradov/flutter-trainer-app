import 'package:flutter/material.dart';
import 'package:workout_app/shared/bgimg.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          BgImg()
        ],
      ),
    );
  }
}
