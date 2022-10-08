import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/widgets/search_bar.dart';

import '../../../../../../core/api/dio_helper.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../logic/home_layout/home_cubit.dart';
import '../../../../../../logic/home_layout/home_states.dart';
import 'MovieItemBuilder.dart';

class ForegroundWidget extends StatefulWidget {
  @override
  State<ForegroundWidget> createState() => _ForegroundWidgetState();
}

class _ForegroundWidgetState extends State<ForegroundWidget> {
  @override
  void initState() {
    MoviesCubit.get(context).getPopularMovies();
    MoviesCubit.get(context).getUserData(userID: uId,fromHomeScreen: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            Helper.getScreenHeight(context: context) * 0.02,
            Helper.getScreenHeight(context: context) * 0.05,
            Helper.getScreenHeight(context: context) * 0.02,
            0,
          ),
          width: Helper.getScreenWidth(context: context),
          height: Helper.getScreenHeight(context: context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchBar(),
              state is FuryGetPopularMoviesLoadingState
                  ? Expanded(
                    child: Center(
                      child: AdaptiveIndicator(
                        color: AppColors.mainColor,
                      os: Components.getOS(),
                      ),
                    ),
                  )
                  : Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.only(
                            top: Helper.getScreenHeight(context: context) *
                                0.02),
                        itemBuilder: (context, index) {
                          return MovieItemBuilder(
                            movieModel: MoviesCubit.get(context)
                                .popularMovies
                                .first
                                .moviesList[index],
                            // dateFontSize: AppFontSize.s16,
                            // titleFontSize: AppFontSize.s18,
                            // descriptionFontSize: AppFontSize.s14,
                            padding: Helper.getPaddingLeft(context: context) * 0.1,
                            width: Helper.getScreenWidth(context: context) * 0.3,
                            height: Helper.getScreenHeight(context: context) * 0.15,
                            baseImageURL: DioHelper.baseImageURL,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height:
                                Helper.getScreenHeight(context: context) * 0.04,
                          );
                        },
                        itemCount: MoviesCubit.get(context)
                            .popularMovies
                            .first
                            .moviesList
                            .length,
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
