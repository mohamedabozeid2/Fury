import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


ThemeData lightTheme = ThemeData(
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
    subtitle2: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  // primarySwatch: Colors.blue,
  // floatingActionButtonTheme:
  // FloatingActionButtonThemeData(backgroundColor: defaultColor),
  scaffoldBackgroundColor: Colors.white,

  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark
    ),
  ),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Colors.white,
  //     selectedItemColor: defaultColor,
  //     elevation: 20.0),
);


