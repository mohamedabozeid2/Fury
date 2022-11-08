import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
        return GNav(
          tabs: MoviesCubit.get(context).bottomNavItems,
          onTabChange: (index) {
            MoviesCubit.get(context).changBotNavBar(index: index);
          },
          padding: EdgeInsets.all(20),
          tabMargin: EdgeInsets.all(10),
          color: Colors.white,
          backgroundColor: Colors.black,
          selectedIndex: MoviesCubit.get(context).botNavCurrentIndex,
          activeColor: Colors.white,
          tabBackgroundColor: AppColors.mainColor,
          textStyle: Theme.of(context).textTheme.subtitle2!.copyWith(),
        );
      },
    );
  }
}
