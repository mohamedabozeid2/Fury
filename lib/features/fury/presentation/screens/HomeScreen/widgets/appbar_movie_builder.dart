import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/border_radius.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/widgets/add_actions_button.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/movie_details_screen.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../../../core/utils/helper.dart';
import '../../../../../../core/widgets/cached_image.dart';
import '../../../../data/models/single_movie_model.dart';

class AppBarMovieBuilder extends StatelessWidget {
  final String image;
  bool fromMovieDetails;
  SingleMovieModel? movie;

  AppBarMovieBuilder({required this.image, this.fromMovieDetails = false, this.movie});

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
                if(!fromMovieDetails){
                  Components.navigateTo(context, MovieDetails(movie:movie!));
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
                  padding: EdgeInsets.symmetric(
                      vertical:
                          Helper.maxHeight * 0.012),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(AppRadius.large2),
                          topLeft: Radius.circular(AppRadius.large2))),
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
                        fun: () {},
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
