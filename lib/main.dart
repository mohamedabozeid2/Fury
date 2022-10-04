import 'package:flutter/material.dart';
import 'package:movies_application/app.dart';

import 'core/api/dio_helper.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  runApp(
      MoviesApp());
  // SplashScreen(key: UniqueKey(), onInitializationComplete: () => MyApp()));
}

