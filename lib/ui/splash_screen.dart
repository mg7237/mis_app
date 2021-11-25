import 'dart:async';

import 'package:mis_app/ui/admin_menu.dart';
import 'package:mis_app/ui/student_home.dart';
import 'package:mis_app/util/firebase_utilities.dart';
import 'package:mis_app/util/preference_connector.dart';
import 'package:mis_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:mis_app/models/user_model.dart';
import 'package:mis_app/util/globals.dart' as globals;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var scaffoldState = GlobalKey<ScaffoldState>();
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    bool rememberMe =
        await PreferenceConnector().getBool(PreferenceConnector.REMEMBER_ME);
    String userId =
        await PreferenceConnector().getString(PreferenceConnector.USER_ID);
    String userType =
        await PreferenceConnector().getString(PreferenceConnector.USER_TYPE);
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    if (isDark) {
      globals.theme = 'DARK';
    } else {
      globals.theme = 'LIGHT';
    }
    globals.theme = 'LIGHT'; // MG temp hardcoding
    PreferenceConnector()
        .setString(PreferenceConnector.THEME_SELECTED, globals.theme);

    if (rememberMe && userId != '' && userType != '') {
      if (userType == 'ADMIN') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AdminMenu()));
      } else {
        String userId =
            await PreferenceConnector().getString(PreferenceConnector.USER_ID);
        User? user = await FirebaseUtilities.getUser(userId);
        if (user != null)
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => StudentHome(email: user.email)));
      }
    } else {
      Navigator.pushReplacementNamed(context, LOGIN);
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldState,
      body: Container(
        color: Colors.white,
        child: new Center(
          child:
              Hero(tag: "logo", child: Image.asset("assets/icon/app_logo.png")),
        ),
      ),
    );
  }
}
