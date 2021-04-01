import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/route/routerName.dart';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart'; // import custom loaders
import 'package:flutter/material.dart';

import 'route/route.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String defRoute;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final token = await sharedPreferences.getString("token");
  print(token);
  if (token != null) {
    defRoute = HomeRoute;
  } else {
    defRoute = LoginRoute;
  }
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(EasyLocalization(
    child: FitApp(defRoute),
    supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
    path: 'assets/translations',
  ));
}

class FitApp extends StatelessWidget {
  FitApp(this.defRoute);
  final String defRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: router.generateRoute,
      initialRoute: defRoute,
    );
  }
}
