import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/app.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/home_screen.dart';

import 'core/api/dio_helper.dart';
import 'features/fury/presentation/cubit/BlocObserver/BlocObserver.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  BlocOverrides.runZoned(
        () {
      runApp(MoviesApp());
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );
}

