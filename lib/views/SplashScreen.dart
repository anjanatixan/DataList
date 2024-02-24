import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_profile/helper/navigation.dart';
import 'package:user_profile/views/bottomNavBar.dart';
import 'package:user_profile/views/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    IsLogedIn(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}

IsLogedIn(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var token = preferences.getString("token");

  log(token.toString());
  if (token == null) {
    Future.delayed(Duration(seconds: 1)).then((value) async {
      NavigationUtils.goNextFinishAll(context, LoginScreen());
    });
  } else {
    Future.delayed(Duration(seconds: 1)).then((value) {
      NavigationUtils.goNextFinishAll(context, BottomNavBar());
    });
  }
}
