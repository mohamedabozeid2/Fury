import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movies_application/core/services/services_locator.dart';
import 'package:movies_application/core/utils/strings.dart';

import 'config/themes/dark_theme/dark_theme.dart';
import 'features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'features/fury/presentation/controller/login_cubit/login_cubit.dart';
import 'features/fury/presentation/controller/news_cubit/news_cubit.dart';

class MoviesApp extends StatelessWidget {
  final Widget startWidget;

  const MoviesApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72727272727275, 788.7272727272727),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (BuildContext context) => MoviesCubit(
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl(),
                    sl())),
            BlocProvider(
                create: (BuildContext context) =>
                    LoginCubit(sl(), sl(), sl(), sl())),
            BlocProvider(
                create: (BuildContext context) =>
                    NewsCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl())),
          ],
          child: GetMaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: darkTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.dark,
            home: child,
          ),
        );
      },
      child: startWidget,
    );
  }
}
