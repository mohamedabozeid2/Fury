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

class InternetConnection extends StatefulWidget {
  const InternetConnection({Key? key}) : super(key: key);

  @override
  State<InternetConnection> createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {
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
                    Get.snackbar(AppStrings.appName, AppStrings.noInternet, colorText: Colors.white, backgroundColor: Colors.redAccent);
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
