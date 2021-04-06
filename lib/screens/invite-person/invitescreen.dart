import 'package:flutter/material.dart';

import 'package:workout_app/const/const.dart';
import 'package:workout_app/screens/invite-person/body.dart';
import 'package:workout_app/shared/hamburgermenu.dart';
import 'package:easy_localization/easy_localization.dart';

class InviteScreen extends StatelessWidget {
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
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: InviteBody(),
        drawer: HamburgerMenu(),
      ),
    );
  }
}
