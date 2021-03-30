import 'package:flutter/material.dart';
import 'package:workout_app/screens/timetable/widget/body.dart';
import 'package:workout_app/shared/hamburgermenu.dart';

class TimetableScreen extends StatelessWidget {
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
        body: BodyTimeTable(),
        drawer: HamburgerMenu(),
      ),
    );
  }
}
