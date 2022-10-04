import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_application/config/app_config.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/widgets/background_widget.dart';
import 'package:movies_application/logic/cubit/cubit.dart';
import 'package:movies_application/logic/cubit/states.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    MoviesCubit.get(context).getData();
    // setup(context).then((value){
    //
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          body: Container(
            height: Helper.getScreenHeight(context: context),
            width: Helper.getScreenWidth(context: context),
            child: Stack(
              alignment: Alignment.center,
              children: [
                BackgroundWidget(),
              ],
            ),
          )
        );
      },
    );
  }
}

Future<void> setup(BuildContext context) async {
  final getIt = GetIt.instance;
  final configFile = await rootBundle.loadString('assets/config/main.json');
  final configData = jsonDecode(configFile);

  getIt.registerSingleton<AppConfig>(AppConfig(
      API_KEY: configData['API_KEY'],
      BASE_API_URL: configData['BASE_API_URL'],
      BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL']));
}
