import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/core/widgets/add_actions_button.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_states.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/movie_details_screen.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../../../core/utils/helper.dart';
import '../../../../../../core/widgets/cached_image.dart';

class AppBarMovieBuilder extends StatelessWidget {
  final String image;
  final bool fromMovieDetails;
  final dynamic movieOrTv;

  const AppBarMovieBuilder({
    super.key,
    required this.image,
    this.fromMovieDetails = false,
    required this.movieOrTv,
  });

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      titlePadding: EdgeInsets.zero,
      background: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () {
                if (!fromMovieDetails) {
                  Components.navigateTo(
                      context,
                      MovieDetails(
                        movieOrTv: movieOrTv,
                      ));
                }
              },
              child: CachedImage(
                fit: BoxFit.cover,
                circularColor: AppColors.mainColor,
                image: image,
                width: Helper.maxWidth,
                height: Helper.maxHeight * 0.75,
              ),
            ),
          ),
          fromMovieDetails
              ? Container()
              : Container(
                  padding: EdgeInsets.symmetric(vertical: AppSize.s3),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(AppSize.s22),
                          topLeft: Radius.circular(AppSize.s22))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocConsumer<MoviesCubit, MoviesStates>(
                        buildWhen: (previous, current) =>
                            current is AddToWatchListLoadingState ||
                            current is AddToWatchListSuccessState,
                        listener: (context, state) {},
                        builder: (context, state) {
                          return state is AddToWatchListLoadingState
                              ? AdaptiveIndicator(
                                  os: Components.getOS(),
                                  color: AppColors.mainColor,
                                )
                              : AddActionsButton(
                                  fun: () {
                                    MoviesCubit.get(context).addToWatchList(
                                      context: context,
                                      mediaId: movieOrTv!.id,
                                      watchList: true,
                                      movieOrTv: movieOrTv,
                                    );
                                  },
                                  icon: Icons.add,
                                  iconSize: AppFontSize.s22,
                                  title: AppStrings.watchList,
                                );
                        },
                      ),
                      AddActionsButton(
                        fun: () {
                          Components.navigateTo(
                            context,
                            MovieDetails(
                              movieOrTv: movieOrTv,
                            ),
                          );
                        },
                        icon: Icons.info,
                        iconSize: AppFontSize.s22,
                        title: AppStrings.info,
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
