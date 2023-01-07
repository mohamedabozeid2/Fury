import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/helper.dart';
import '../../../../../../core/utils/Colors.dart';
import '../../../controller/home_cubit/home_cubit.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context , BoxConstraints constraints) {
        Helper.maxWidth = constraints.maxWidth;
        Helper.maxHeight = constraints.maxHeight;
        return GNav(
          tabs: MoviesCubit.get(context).bottomNavItems,
          onTabChange: (index) {
            MoviesCubit.get(context).changBotNavBar(index: index);
          },
          padding: EdgeInsets.all(Helper.maxWidth*0.03),
          tabMargin: EdgeInsets.all(Helper.maxWidth*0.02),
          color: Colors.white,
          backgroundColor: Colors.black,
          selectedIndex: MoviesCubit.get(context).botNavCurrentIndex,
          activeColor: Colors.white,
          iconSize: AppFontSize.s18,
          tabBackgroundColor: AppColors.mainColor,
          textStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
              fontSize: AppFontSize.s14
          ),
        );
      },
    );
  }
}
