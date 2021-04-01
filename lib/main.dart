import 'package:workout_app/route/routerName.dart';
import 'package:workout_app/screens/auth/authscreen.dart';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart'; // import custom loaders
import 'package:flutter/material.dart';
import 'route/route.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(EasyLocalization(
    child: FitApp(),
    supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
    path: 'assets/translations',
  ));
}

class FitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // home: AuthScreen(),
      onGenerateRoute: router.generateRoute,
      initialRoute: LoginRoute,
    );
  }
}
