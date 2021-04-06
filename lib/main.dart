import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/route/routerName.dart';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart'; // import custom loaders
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'route/route.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.init("70190b13-85aa-4308-bec0-eb3f8b6f1f78", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
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

class FitApp extends StatefulWidget {
  FitApp(this.defRoute);
  final String defRoute;

  @override
  _FitAppState createState() => _FitAppState();
}

class _FitAppState extends State<FitApp> {
  @override
  void initState() {
    super.initState();
    OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
    // will be called whenever a notification is received
});

OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  // will be called whenever a notification is opened/button pressed.
});
  }

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
      initialRoute: widget.defRoute,
    );
  }
}
