import 'package:flutter/material.dart';
import 'package:workout_app/screens/auth/authscreen.dart';
import 'package:workout_app/screens/home/homescreen.dart';

void main() {
  runApp(FitApp());
}

class FitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black),
      home: AuthScreen(),
    );
  }
}
