import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/app.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/services/services_locator.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/features/fury/presentation/screens/login_screen/login_screen.dart';

import 'core/api/movies_dio_helper.dart';
import 'core/api/news_dio_helper.dart';
import 'core/shared_preference/cache_helper.dart';
import 'features/fury/presentation/controller/BlocObserver/BlocObserver.dart';
import 'features/fury/presentation/screens/Layout/Layout.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  ServicesLocator().init();
  Widget startWidget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    startWidget = const Layout();
  } else {
    startWidget = const LoginScreen();
  }

  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent, // st
  //     // a
  //     statusBarBrightness: Brightness.light,
  //     statusBarIconBrightness: Brightness.light // tus bar color
  //     ));

  await CheckConnection.checkConnection().then((value) {
    internetConnection = value;
  });


  MoviesDioHelper.init();
  NewsDioHelper.init();
  BlocOverrides.runZoned(
    () {
      runApp(MoviesApp(
        startWidget: startWidget,
      ));
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );
}
