import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:workout_app/const/const.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
      ),
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
            child: HeaderTxt(),
            flex: 1,
          ),
          new Expanded(
            child: Column(
                //mainAxisAlignment:MainAxisAlignment.,

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
        Text(
          "trainer".tr().toString(),
          // text
          textAlign: TextAlign.center,
          style: TextStyle(
            color: MainColor,
            fontSize: 40,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
          ),
        ),
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
      fontSize: 25,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "payment".tr().toString(),
          style: textStyle,
        ),
        Text(
          "timetable".tr().toString(),
          style: textStyle,
        ),
        Text(
          'Statistics'.tr().toString(),
          style: textStyle,
        ),
      ],
    );
  }
}
