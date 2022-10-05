import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_application/config/themes/light_theme/light_theme.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/home_screen.dart';

import 'features/fury/presentation/cubit/cubit.dart';



class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => MoviesCubit())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home: HomeScreen(),
      ),
    );
  }

}
