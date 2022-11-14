import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/logic/home_layout/home_cubit.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';

import '../../../../../../core/utils/Colors.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},

      builder: (context, state) {
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
      },
    );
  }
}
