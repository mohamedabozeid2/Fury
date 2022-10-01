import 'package:flutter/material.dart';
import 'package:movies_application/app.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MoviesApp());
  // SplashScreen(key: UniqueKey(), onInitializationComplete: () => MyApp()));
}

