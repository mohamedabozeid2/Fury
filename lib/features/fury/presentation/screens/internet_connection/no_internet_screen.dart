import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/button.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/home_screen.dart';

class NoInternetScreen extends StatefulWidget {

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset('assets/anims/connection.json'),
        const SizedBox(
          height: 10,
        ),
        Text(
          AppStrings.noInternet,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 10.0,
        ),
        DefaultButton(
            fun: () async {
              await CheckConnection.checkConnection().then((value){
                setState(() {
                  if(value == true) {
                    internetConnection = true;
                    Components.navigateAndFinish(context: context, widget: HomeScreen());
                  }else{
                    internetConnection = false;
                    Components.showSnackBar(title: AppStrings.appName, message: AppStrings.noInternet, backgroundColor: Colors.redAccent, textColor: Colors.white);
                  }
                });
              });
            },
            text: AppStrings.refresh,
            height: Helper.getScreenHeight(context: context) * 0.07,
            width: Helper.getScreenWidth(context: context)*0.4,
            textColor: Colors.white,
            backgroundColor: AppColors.mainColor,
            fontSize: AppFontSize.s14,
            borderRadius: 15.0)
      ],
    ));
  }
}
