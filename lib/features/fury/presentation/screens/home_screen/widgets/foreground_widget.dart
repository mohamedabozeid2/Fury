import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/api/dio_helper.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/widgets/MovieItemBuilder.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/widgets/search_bar.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class ForegroundWidget extends StatefulWidget {
  @override
  State<ForegroundWidget> createState() => _ForegroundWidgetState();
}

class _ForegroundWidgetState extends State<ForegroundWidget> {
  @override
  void initState() {
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchBar(),
              state is MoviesGetPopularMoviesLoadingState
                  ? Center(
                      child: AdaptiveIndicator(
                      os: Components.getOS(),
                    ))
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
