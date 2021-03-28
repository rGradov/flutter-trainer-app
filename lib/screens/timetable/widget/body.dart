import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:workout_app/const/const.dart';

class BodyTimeTable extends StatefulWidget {
  @override
  _BodyTimeTableState createState() => _BodyTimeTableState();
}

class _BodyTimeTableState extends State<BodyTimeTable> {
  CalendarController _controller;
  String _loc = 'ru_RU';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    // _loc = context.locale.toString();
    print(_loc);
  }

  initLoc() {
    print(context.locale);
    if (context.locale.toString() == 'en_US') {
      return 'en_US';
    } else {
      return 'ru_RU';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              TableCalendar(
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                    todayColor: MainColor,
                    selectedColor: Colors.green,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white),
                    weekendStyle: TextStyle(
                      color: Colors.white70,
                    ),
                    weekdayStyle: TextStyle(color: Colors.white)),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
                  leftChevronIcon:
                      Icon(Icons.chevron_left, color: Colors.white),
                  rightChevronIcon:
                      Icon(Icons.chevron_right, color: Colors.white),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  weekendStyle: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                locale: initLoc(),
                calendarController: _controller,
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                padding: EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      50,
                    ),
                    topRight: Radius.circular(50),
                  ),
                  color: Colors.green,
                  border: Border.all(color: MainColor),
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            'Today', //fix this
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    );
  }
}
