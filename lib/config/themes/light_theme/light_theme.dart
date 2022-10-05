import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_application/core/utils/app_fonts.dart';

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    headline6: TextStyle(
      // fontSize: AppFontSize.s60,
      color: Colors.white,
      fontWeight: FontWeightManager.bold,
    ),
    bodyText1: TextStyle(
      // fontSize: AppFontSize.s24,
      fontWeight: FontWeightManager.semiBold,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
        // fontSize: AppFontSize.s20,
        fontWeight: FontWeightManager.semiBold,
        color: Colors.black),
    subtitle2: TextStyle(
      // fontSize: AppFontSize.s14,
      fontWeight: FontWeightManager.regular,
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
        statusBarBrightness: Brightness.dark),
  ),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: Colors.white,
  //     selectedItemColor: defaultColor,
  //     elevation: 20.0),
);
