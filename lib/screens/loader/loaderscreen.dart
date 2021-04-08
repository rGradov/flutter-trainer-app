import 'package:flutter/material.dart';
import 'package:workout_app/screens/loader/body.dart';

class LoadScreen extends StatelessWidget {
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
                 automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.transparent,
        body: LoaderBody(),
        // drawer: HamburgerMenu(),
      ),
    );
  }
}
