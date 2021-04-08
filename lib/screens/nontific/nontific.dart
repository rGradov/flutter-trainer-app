import 'package:flutter/material.dart';
import 'package:workout_app/screens/nontific/body.dart';

class NontificationScreen extends StatelessWidget {
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
        body: NontificBody(),
        // drawer: HamburgerMenu(),
      ),
    );
  }
}
