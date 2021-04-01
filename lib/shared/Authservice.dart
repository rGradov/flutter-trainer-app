import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = await sharedPreferences.getString("token");
    if (token != 0) {
      return true;
    } else {
      return false;
    }
  }
}
