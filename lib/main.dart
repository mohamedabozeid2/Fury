import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/app.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/home_screen.dart';

import 'core/api/dio_helper.dart';
import 'features/fury/presentation/cubit/BlocObserver/BlocObserver.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // st
      // a
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark // tus bar color
  ));

  await CheckConnection.checkConnection().then((value){
    internetConnection = value;
  });


  DioHelper.init();

  BlocOverrides.runZoned(
        () {
      runApp(MoviesApp());
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );
}

