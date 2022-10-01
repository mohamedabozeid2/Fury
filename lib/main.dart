import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Modules/HomeScreen/HomeScreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MyApp());
  // SplashScreen(key: UniqueKey(), onInitializationComplete: () => MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fury',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
