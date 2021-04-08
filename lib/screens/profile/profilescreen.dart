import 'package:flutter/material.dart';

import 'package:workout_app/const/const.dart';
import 'package:workout_app/reset-pswd/resetBody.dart';
import 'package:workout_app/screens/profile/profilebody.dart';
import 'package:workout_app/shared/hamburgermenu.dart';

class ProfileScreen extends StatelessWidget {
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: ProfileBody(),
        // drawer: HamburgerMenu(),
      ),
    );
  }
}
