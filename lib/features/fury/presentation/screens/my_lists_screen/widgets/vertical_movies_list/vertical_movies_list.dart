import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_states.dart';

import '../../../../../../../core/utils/helper.dart';
import '../../../../../../../core/widgets/divider.dart';

class VerticalMoviesList extends StatefulWidget {
  const VerticalMoviesList({
    Key? key,
  }) : super(key: key);

  @override
  State<VerticalMoviesList> createState() => _VerticalMoviesListState();
}

class _VerticalMoviesListState extends State<VerticalMoviesList> {
  late int tvShowsCounter;

  List myWatchList = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    myWatchList.addAll(moviesWatchList!.moviesList);
    myWatchList.addAll(tvShowsWatchList!.tvList);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          {
            debugPrint('Loading');
          }
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      buildWhen: (previous, current) => current is AddToWatchListSuccessState,
      listener: (context, state) {},
      builder: (context, state) {
        print("TEST ${myWatchList.length}");
        print(myWatchList.last);
        tvShowsCounter = moviesWatchList!.moviesList.length;
        return Column(
          children: [
            SizedBox(
              height: Helper.maxHeight * 0.01,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  bool isMovie;
                  if(index <= moviesWatchList!.moviesList.length){
                    isMovie = true;
                  }else{
                    isMovie = false;
                  }
                  print(isMovie);
                  return Container();
                },
                separatorBuilder: (context, index) {
                  return MyDivider(color: Colors.red);
                },
                itemCount: myWatchList.length,
              ),
            )
            // NotificationListener<ScrollUpdateNotification>(
            //   onNotification: (value){
            //     if(scrollController.position.atEdge){
            //       if(scrollController.position.pixels!=0){
            //         if(state is LoadMoreMyListLoadingState){
            //           debugPrint('Loading');
            //         }else{
            //
            //         }
            //       }
            //     }
            //     return true;
            //   },
            //   child: ListView.separated(
            //     physics: const NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     // controller: scrollController,
            //     itemBuilder: (context, index) {
            //       return VerticalMoviesItemBuilder(
            //         moviesCounter: index+1,
            //         isMovie: true,
            //         movie: moviesWatchList!.moviesList[index],
            //       );
            //     },
            //     separatorBuilder: (context, index) {
            //       return MyDivider(
            //         color: AppColors.mainColor,
            //         paddingHorizontal: 0,
            //       );
            //     },
            //     itemCount: moviesWatchList!.moviesList.length,
            //   ),
            // ),
            // MyDivider(
            //   color: AppColors.mainColor,
            //   paddingHorizontal: 0,
            // ),
            // Text("TV NOW"),
            // ListView.separated(
            //   physics: const NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {
            //     tvShowsCounter += index;
            //     return VerticalMoviesItemBuilder(
            //       moviesCounter: tvShowsCounter+1,
            //       isMovie: false,
            //       tv: tvShowsWatchList!.tvList[index],
            //     );
            //   },
            //   separatorBuilder: (context, index) {
            //     return MyDivider(
            //       color: AppColors.mainColor,
            //       paddingHorizontal: 0,
            //     );
            //   },
            //   itemCount: tvShowsWatchList!.tvList.length,
            // )
          ],
        );
      },
    );
  }
}
