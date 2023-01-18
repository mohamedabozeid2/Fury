import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/helper.dart';

import '../../../../../core/utils/components.dart';
import '../../../../../core/widgets/adaptive_indicator.dart';
import '../../controller/home_cubit/home_cubit.dart';
import '../../controller/home_cubit/home_states.dart';
import '../drawer_screen/home_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key, this.fromFavoriteScreen = false});

  final bool fromFavoriteScreen;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  void initState() {
    if (widget.fromFavoriteScreen == false) {
      MoviesCubit.get(context).getAllMovies(context: context);
      // NewsCubit.get(context).getAllNews();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      buildWhen: (previous, current) =>
          current is GetAllMoviesSuccessState ||
          current is GetAllMoviesLoadingState,
      listener: (context, state) {},
      builder: (context, state) {
        return state is GetAllMoviesLoadingState
            ? Center(
                child: AdaptiveIndicator(
                os: Components.getOS(),
                color: AppColors.mainColor,
              ))
            : LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            Helper.maxWidth = constraints.maxWidth;
            Helper.maxHeight = constraints.maxHeight;
            return const HomeScreen();
          },
        );/*Scaffold(
                bottomNavigationBar: const BottomNavBar(),
                body: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    Helper.maxWidth = constraints.maxWidth;
                    Helper.maxHeight = constraints.maxHeight;
                    return MoviesCubit.get(context)
                        .screens[MoviesCubit.get(context).botNavCurrentIndex];
                  },
                ));*/
      },
    );
  }
}
