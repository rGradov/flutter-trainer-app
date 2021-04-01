import 'package:flutter/material.dart';
import 'package:workout_app/const/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:workout_app/route/routerName.dart';
import 'package:workout_app/screens/auth/authscreen.dart';

class HamburgerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          // padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: MainColor,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => {
                 Navigator.pushNamedAndRemoveUntil(context, LoginRoute, (r) => false)
              },
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.account_circle,
            //     color: MainColor,
            //   ),
            //   title: Text(
            //     "login-btn-text".tr().toString(),
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onTap: () => {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => AuthScreen(),
            //         ))
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
