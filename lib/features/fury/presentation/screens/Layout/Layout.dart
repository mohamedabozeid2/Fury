import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/features/fury/presentation/screens/Layout/widgets/bottom_nav_bar.dart';
import 'package:movies_application/logic/home_layout/home_cubit.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';

import '../../../../../core/utils/components.dart';
import '../../../../../core/widgets/adaptive_indicator.dart';

class Layout extends StatefulWidget {
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  void initState() {
    MoviesCubit.get(context).getAllMovies(context: context);
    MoviesCubit.get(context).getUserData(userID: uId, fromHomeScreen: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is GetAllMoviesLoadingState
            ? Center(
                child: AdaptiveIndicator(
                os: Components.getOS(),
                color: AppColors.mainColor,
              ))
            : Scaffold(
                bottomNavigationBar: BottomNavBar(),
                body: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    Helper.maxWidth = constraints.maxWidth;
                    Helper.maxHeight = constraints.maxHeight;
                    return MoviesCubit.get(context)
                        .screens[MoviesCubit.get(context).botNavCurrentIndex];
                  },
                ));
      },
    );
  }
}
