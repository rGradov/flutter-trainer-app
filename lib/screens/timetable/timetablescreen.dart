import 'package:flutter/material.dart';
import 'package:workout_app/screens/timetable/widget/body.dart';

class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
      ),
      child: BodyTimeTable(),
      );
     
  }
}