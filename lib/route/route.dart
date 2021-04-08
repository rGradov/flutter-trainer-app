import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:workout_app/reset-pswd/reset.dart';
import 'package:workout_app/route/routerName.dart';
import 'package:workout_app/screens/auth/authscreen.dart';
import 'package:workout_app/screens/auth/register/registerscreen.dart';
import 'package:workout_app/screens/home/homescreen.dart';
import 'package:workout_app/screens/invite-person/invitescreen.dart';
import 'package:workout_app/screens/loader/loaderscreen.dart';
import 'package:workout_app/screens/nontific/nontific.dart';
import 'package:workout_app/screens/profile/profilescreen.dart';
import 'package:workout_app/screens/timetable/timetablescreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case NontificationRoute:
      return MaterialPageRoute(builder: (context) => NontificationScreen());
    case LoginRoute:
      return PageTransition(
        child: AuthScreen(),
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 500),
      );
      break;
    case RegisterRoute:
      return PageTransition(
        child: RegScreen(),
        type: PageTransitionType.leftToRight,
        duration: Duration(milliseconds: 500),
      );
    case TimeTableRoute:
      return MaterialPageRoute(builder: (context) => TimetableScreen());
      break;
    case ResetPswdRoute:
      return PageTransition(
        child: ResetScreen(),
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 500),
      );
      break;
    case InviteRoute:
      return PageTransition(
        child: InviteScreen(),
        type: PageTransitionType.leftToRight,
        duration: Duration(milliseconds: 500),
      );
      break;
    case ProfileRoute:
      return PageTransition(
        child: ProfileScreen(),
        type: PageTransitionType.leftToRight,
        duration: Duration(milliseconds: 500),
      );
      break;
    case LoaderRoute:
      return PageTransition(
        child: LoadScreen(),
        type: PageTransitionType.leftToRight,
        duration: Duration(milliseconds: 500),
      );
    default:
      MaterialPageRoute(builder: (context) => HomeScreen());
  }
}
