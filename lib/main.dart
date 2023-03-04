import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:movies_application/app.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/notifications/local_notifications/local_notifications.dart';
import 'package:movies_application/core/services/services_locator.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:path_provider/path_provider.dart';

import 'core/api/movies_dio_helper.dart';
import 'core/api/news_dio_helper.dart';
import 'core/hive/hive_helper.dart';
import 'features/fury/presentation/controller/BlocObserver/BlocObserver.dart';
import 'features/fury/presentation/screens/Layout/Layout.dart';
import 'features/fury/presentation/screens/login_screen/login_screen.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  directory = await getApplicationDocumentsDirectory();
  await HiveHelper.init(path: directory!.path);
  //
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await NotificationService.initNotification().then((value) {
    NotificationService.showDailyNotification(
      id: 0,
      title: 'Fury',
      body: 'Watch Movies Now',
      dayTime: const Time(14, 42, 0),
    );
  });
  ServicesLocator().init();
  Widget startWidget;

  sessionId = HiveHelper.getSessionIdBox();
  accountDetails = HiveHelper.getAccountDetailsBox();
  if (accountDetails == null) {
    startWidget = const LoginScreen();
  } else {
    startWidget = const Layout();
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
      runApp(
        DevicePreview(
          enabled: /*!kReleaseMode*/false, ////true
          builder: (context) => MoviesApp(
            startWidget: startWidget,
          ),
        ),
      );
      // runApp(MoviesApp(
      //   startWidget: startWidget,
      // ));
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );
}
