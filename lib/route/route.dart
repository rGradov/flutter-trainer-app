
import 'package:flutter/material.dart';
import 'package:workout_app/route/routerName.dart';
import 'package:workout_app/screens/auth/authscreen.dart';
import 'package:workout_app/screens/auth/register/registerscreen.dart';
import 'package:workout_app/screens/home/homescreen.dart';
import 'package:workout_app/screens/timetable/timetablescreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case LoginRoute:
      return MaterialPageRoute(builder: (context) => AuthScreen());
    case RegisterRoute:
      return MaterialPageRoute(builder: (context) => RegScreen());
    case TimeTableRoute:
      return MaterialPageRoute(builder: (context) => TimetableScreen());
      break;
    default: MaterialPageRoute(builder: (context) => HomeScreen());
  }
}
