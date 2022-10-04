import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/home_screen.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/helper.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer(const Duration(milliseconds: 2500), () {
      Components.navigateAndFinish(context: context, widget: HomeScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.splashColor,
        body: Center(
            child: Image(
                image: AssetImage(ImageAssets.splashScreen),
                height: Helper.getScreenHeight(context: context) * 0.3)),
      ),
    );
  }
}
