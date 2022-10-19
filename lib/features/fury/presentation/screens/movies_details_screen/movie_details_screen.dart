import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/core/widgets/add_actions_button.dart';
import 'package:movies_application/core/widgets/cached_image.dart';
import 'package:movies_application/features/fury/data/models/movie_keywards_model.dart';
import 'package:movies_application/features/fury/data/models/single_movie_model.dart';
import 'package:movies_application/features/fury/presentation/screens/movies_details_screen/widgets/rate_row.dart';
import 'package:movies_application/logic/home_layout/home_cubit.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';
import '../../../../../core/api/dio_helper.dart';
import '../../../../../core/utils/helper.dart';
import '../home_screen/widgets/appbar_movie_builder.dart';

class MovieDetails extends StatefulWidget {
  SingleMovieModel movie;

  MovieDetails({required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    MoviesCubit.get(context).getMovieKeyword(movieId: widget.movie.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: state is FuryGetMovieKeywordLoadingState
                ? Center(
                    child: AdaptiveIndicator(
                      os: Components.getOS(),
                      color: AppColors.mainColor,
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        expandedHeight:
                            Helper.getScreenHeight(context: context) * 0.7,
                        flexibleSpace: AppBarMovieBuilder(
                            fromMovieDetails: true,
                            image:
                                '${DioHelper.baseImageURL}${widget.movie.posterPath}'),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: EdgeInsets.all(
                              Helper.getScreenHeight(context: context) * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  RateRow(rate: widget.movie.rate!),
                                  const Spacer(),
                                  AddActionsButton(
                                      fun: () {},
                                      icon: Icons.add,
                                      iconSize: AppFontSize.s26),
                                  AddActionsButton(
                                      fun: () {},
                                      icon: Icons.favorite,
                                      iconSize: AppFontSize.s26),
                                ],
                              ),
                              SizedBox(
                                height:
                                    Helper.getScreenHeight(context: context) *
                                        0.03,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: widget.movie.name != null
                                          ? Text(
                                              widget.movie.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            )
                                          : Container()),
                                  widget.movie.isAdult!
                                      ? Text(
                                          '+18',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(
                                height:
                                    Helper.getScreenHeight(context: context) *
                                        0.008,
                              ),
                              widget.movie.releaseDate != null
                                  ? Text(
                                      '${widget.movie.releaseDate}',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    )
                                  : Text('Release Date is unknown',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                              Text(
                                'Language: ${widget.movie.language}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                height:
                                    Helper.getScreenHeight(context: context) *
                                        0.01,
                              ),
                              MoviesCubit.get(context).keywords != null
                                  ? SizedBox(
                                      height: Helper.getScreenHeight(
                                              context: context) *
                                          0.03,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Text(
                                                  '#${MoviesCubit.get(context).keywords!.keywords[index].name} ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2,
                                                );
                                              },
                                              itemCount:
                                                  MoviesCubit.get(context)
                                                      .keywords!
                                                      .keywords
                                                      .length,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Text(
                                '${widget.movie.description}',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              SizedBox(
                                height:
                                    Helper.getScreenHeight(context: context) *
                                        0.02,
                              ),
                              CachedImage(
                                image:
                                    '${DioHelper.baseImageURL}${widget.movie.backDropPath}',
                                height:
                                    Helper.getScreenHeight(context: context) *
                                        0.3,
                                width: Helper.getScreenWidth(context: context),
                                circularColor: AppColors.mainColor,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
      },
    );
  }
}
