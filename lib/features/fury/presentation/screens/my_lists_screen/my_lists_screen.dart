import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        title: Row(
          children: const [
            DrawerIconButton(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
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
                return moviesWatchList!.moviesList.isEmpty &&
                        tvShowsWatchList!.tvList.isEmpty
                    ? const NoWatchListAvailableScreen()
                    : const VerticalMoviesList();
              },
            ),
          ],
        ),
      ),
    );
  }
}
