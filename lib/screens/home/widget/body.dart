import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:workout_app/const/const.dart';
import 'package:workout_app/screens/timetable/timetablescreen.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MainText(),
    );
  }
}

class MainText extends StatelessWidget {
  const MainText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          new Expanded(
            child: Column(),
            flex: 1,
          ),
          new Expanded(
            child: Column(
                //mainAxisAlignment:MainAxisAlignment.,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Navigations()]),
            flex: 2,
          )
        ],
      ),
    );
  }
}

class HeaderTxt extends StatelessWidget {
  const HeaderTxt({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   "trainer".tr().toString(),
        //   // text
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     color: MainColor,
        //     fontSize: 40,
        //     fontWeight: FontWeight.w400,
        //     decoration: TextDecoration.underline,
        //   ),
        // ),
      ],
    );
  }
}

class Navigations extends StatelessWidget {
  const Navigations({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.white,
      fontSize: 35,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                      padding: const EdgeInsets.only(left: 10,),
                alignment: FractionalOffset.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: GestureDetector(
                    child: Text(
                      "payment".tr().toString(),
                      textAlign: TextAlign.left,
                      style: textStyle,
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
          Container(
                            padding: const EdgeInsets.only(left: 10,),
            alignment: FractionalOffset.centerLeft,
            child: Padding(
              padding: EdgeInsets.only( bottom: 10),
              child: GestureDetector(
                child: Text("timetable".tr().toString(),
                    textAlign: TextAlign.left, style: textStyle),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimetableScreen()),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10,),
            alignment: FractionalOffset.centerLeft,
            child: Padding(
              padding: EdgeInsets.only( bottom: 10),
              child: GestureDetector(
                child: Text("workouts".tr().toString(),
                    textAlign: TextAlign.left, style: textStyle),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => TimetableScreen()),
                  // );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10,),
            alignment: FractionalOffset.centerLeft,
            child: Padding(
              padding: EdgeInsets.only( bottom: 10),
              child: GestureDetector(
                child: Text("statistics".tr().toString(),
                    textAlign: TextAlign.left, style: textStyle),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => TimetableScreen()),
                  // );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
