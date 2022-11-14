import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movies_application/config/themes/light_theme/light_theme.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/logic/login_cubit/login_cubit.dart';
import 'package:movies_application/logic/news_cubit/news_cubit.dart';

import 'logic/home_layout/home_cubit.dart';
import 'logic/register_cubit/register_cubit.dart';

class MoviesApp extends StatelessWidget {

  Widget startWidget;
  MoviesApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72727272727275, 788.7272727272727),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => MoviesCubit()),
            BlocProvider(create: (BuildContext context) => LoginCubit()),
            BlocProvider(create: (BuildContext context) => RegisterCubit()),
            BlocProvider(create: (BuildContext context) => NewsCubit()),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: lightTheme,
            themeMode: ThemeMode.light,
            home: child,
          ),
        );
      },
      child: startWidget,
    );
  }
}
