import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/widgets/add_actions_button.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/movie_details_screen.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../../../core/utils/helper.dart';
import '../../../../../../core/widgets/cached_image.dart';
import '../../../../data/models/single_movie.dart';
import '../../../../data/models/single_tv.dart';

class AppBarMovieBuilder extends StatelessWidget {
  final String image;
  final bool fromMovieDetails;
  final bool isMovie;
  final SingleMovie? movie;
  final SingleTV? tv;

  const AppBarMovieBuilder({
    super.key,
    required this.image,
    this.fromMovieDetails = false,
    this.movie,
    this.tv,
    required this.isMovie,
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
                  if (isMovie) {
                    Components.navigateTo(
                        context,
                        MovieDetails(
                          movie: movie!,
                          isMovie: isMovie,
                        ));
                  } else {
                    Components.navigateTo(
                        context,
                        MovieDetails(
                          tvShow: tv,
                          isMovie: isMovie,
                        ));
                  }
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
                  padding:
                      EdgeInsets.symmetric(vertical: Helper.maxHeight * 0.012),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(AppSize.s22),
                          topLeft: Radius.circular(AppSize.s22))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AddActionsButton(
                        fun: () {},
                        icon: Icons.add,
                        iconSize: AppFontSize.s22,
                        title: 'Later',
                      ),
                      AddActionsButton(
                        fun: () {
                          MoviesCubit.get(context).markAsFavorite(
                            isMovie: isMovie,
                            mediaId: isMovie ? movie!.id : tv!.id,
                            favorite: true,
                          );
                        },
                        icon: Icons.favorite,
                        iconSize: AppFontSize.s22,
                        title: 'Favorite',
                      ),
                      AddActionsButton(
                        fun: () {},
                        icon: Icons.info,
                        iconSize: AppFontSize.s22,
                        title: 'Info',
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
