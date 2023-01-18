import 'package:flutter/material.dart';

import '../utils/Colors.dart';
import '../utils/app_fonts.dart';
import '../utils/app_values.dart';
import '../utils/constants.dart';


class DrawerIconButton extends StatelessWidget {
  const DrawerIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        drawerController.toggle?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s20),
          color: AppColors.mainColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSize.s12),
          child: Icon(Icons.menu, size: AppFontSize.s24, color: AppColors.whiteButtonText,),
        )/*Image(
                    image: const AssetImage('assets/images/logo2.png'),
                    height: Helper.maxHeight * 0.05,
                  )*/,
      ),
    );
  }
}
