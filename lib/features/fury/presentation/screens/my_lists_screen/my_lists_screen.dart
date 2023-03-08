import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/presentation/screens/my_lists_screen/widgets/no_watch_list_available.dart';
import 'package:movies_application/features/fury/presentation/screens/my_lists_screen/widgets/vertical_movies_list/vertical_movies_list.dart';

import '../../../../../core/utils/app_values.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/drawer_icon_button.dart';
import '../../controller/home_cubit/home_cubit.dart';
import '../../controller/home_cubit/home_states.dart';

class MyListsScreen extends StatefulWidget {
  const MyListsScreen({super.key});

  @override
  State<MyListsScreen> createState() => _MyListsScreenState();
}

class _MyListsScreenState extends State<MyListsScreen> {
  final ScrollController scrollController = ScrollController();

  bool hasNextPage = true;

  bool isLoadingMoreRunning = false;

  bool loadMore = false;

  late int page;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          debugPrint("TOP");
        } else {
          debugPrint("BOT");
          MoviesCubit.get(context).loadMoreInWatchList();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppSize.s70,
        backgroundColor: Colors.transparent,
        elevation: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const DrawerIconButton(),
            PopupMenuButton(
                color: AppColors.mainColor,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s20),
                      border: Border.all(color: AppColors.mainColor)
                      // color: AppColors.mainColor,
                      ),
                  child: Padding(
                    padding: EdgeInsets.all(AppSize.s8),
                    child: Icon(Icons.expand_more_outlined,
                        size: AppFontSize.s34, color: AppColors.mainColor),
                  ),
                ),
                onSelected: (value) {
                  if (value == 1) {
                    MoviesCubit.get(context).pickRandomMovie(context: context);
                  } else if (value == 2) {
                    MoviesCubit.get(context)
                        .shuffleMoviesList(moviesList: watchListData);
                  } else if (value == 3) {
                    if(watchListData[30] == watchListData.last){
                    }else{


                    }
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          AppStrings.pickRandomMovie,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text(
                          AppStrings.shuffle,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Text(
                          'SHOW LENGTH',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ]),
          ],
        ),
      ),
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            // hasScrollBody: true,
            // fillOverscroll: true,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s20,
                    vertical: AppSize.s20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        AppStrings.myWatchList,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ),
                BlocConsumer<MoviesCubit, MoviesStates>(
                  buildWhen: (previous, current) =>
                      current is AddToWatchListSuccessState ||
                      current is LoadMoreWatchListLoadingState ||
                      current is LoadMoreWatchListSuccessState,
                  listener: (context, state) {},
                  builder: (context, state) {
                    return watchListData.isEmpty
                        ? const NoWatchListAvailableScreen()
                        : const VerticalMoviesList();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
