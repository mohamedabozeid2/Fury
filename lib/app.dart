import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movies_application/config/themes/light_theme/light_theme.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/home_screen.dart';
import 'package:movies_application/features/fury/presentation/screens/internet_connection/no_internet_screen.dart';
import 'package:movies_application/features/fury/presentation/screens/splash_screen/splash_screen.dart';
import 'package:movies_application/logic/login_cubit/login_cubit.dart';

import 'logic/home_layout/home_cubit.dart';
import 'logic/register_cubit/register_cubit.dart';

class MoviesApp extends StatelessWidget {

  Widget startWidget;
  MoviesApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => MoviesCubit()),
            BlocProvider(create: (BuildContext context) => LoginCubit()),
            BlocProvider(create: (BuildContext context) => RegisterCubit()),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: lightTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          ),
        );
      },
    );
  }
}
