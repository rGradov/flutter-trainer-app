import 'package:flutter/material.dart';
import 'package:workout_app/const/const.dart';
import 'package:workout_app/shared/hamburgermenu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'widget/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
           centerTitle: true,
          title: Text(
          "trainer".tr().toString(),
          // text
          textAlign: TextAlign.center,
          style: TextStyle(
          
            color: MainColor,
            fontSize: 50,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
          ),
        ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Body(),
        drawer: HamburgerMenu(),
      ),
    );
  }
}
