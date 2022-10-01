import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_application/config/app_config.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    setup(context).then((value){
      print('done');
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fury'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'WTF',
              style: TextStyle(fontSize: 50.0),
            )
          ],
        ),
      ),
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
  print("OK");
}
