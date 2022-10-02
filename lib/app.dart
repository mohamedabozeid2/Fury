import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_application/core/utils/strings.dart';

import 'features/fury/presentation/screens/HomeScreen/HomeScreen.dart';


class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }

}
