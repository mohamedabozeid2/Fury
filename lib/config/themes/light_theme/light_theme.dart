import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_fonts.dart';

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    headline5: TextStyle(
      fontSize: AppFontSize.s34,
      color: Colors.white,
      fontWeight: FontWeightManager.bold,
    ),
    headline6: TextStyle(
      fontSize: AppFontSize.s26,
      color: Colors.white,
      fontWeight: FontWeightManager.bold,
    ),
    bodyText1: TextStyle(
      fontSize: AppFontSize.s24,
      fontWeight: FontWeightManager.semiBold,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
        fontSize: AppFontSize.s20,
        fontWeight: FontWeightManager.semiBold,
        color: Colors.white),
    subtitle1: TextStyle(
        fontSize: AppFontSize.s18,
        fontWeight: FontWeightManager.regular,
        color: Colors.white),
    subtitle2: TextStyle(
      fontSize: AppFontSize.s14,
      fontWeight: FontWeightManager.regular,
      color: Colors.white,
    ),
  ),
  // primarySwatch: Colors.blue,
  // floatingActionButtonTheme:
  // FloatingActionButtonThemeData(backgroundColor: defaultColor),
  scaffoldBackgroundColor: Colors.black,

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
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,

      selectedItemColor: AppColors.mainColor,
      showUnselectedLabels: false,
      unselectedItemColor: AppColors.textWhiteColor,
      elevation: 20.0),
);
