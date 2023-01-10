import 'package:flutter/material.dart';
import 'package:movies_application/features/fury/presentation/screens/my_lists_screen/widgets/vertical_movies_list/vertical_movies_list.dart';

import '../../../../../core/widgets/drawer_icon_button.dart';


class MyListsScreen extends StatelessWidget {
  const MyListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DrawerIconButton(),
      ),
      body: Column(
        children: const [
          SingleChildScrollView(child: VerticalMoviesList()),
        ],
      ),
    ) /*DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: AppSize.s5,
            bottom: TabBar(
              indicatorWeight: AppSize.s4,
              indicatorColor: AppColors.mainColor,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.favorite,
                    size: AppSize.s20,
                  ),
                  child: Text(
                    AppStrings.favorite,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.movie_filter_outlined,
                    size: AppSize.s20,
                  ),
                  child: Text(
                    AppStrings.watchLater,
                    style: Theme.of(context).textTheme.subtitle1!,
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(children: [
            FavoriteScreen(),
            WatchLaterScreen()
          ])),
    )*/
        ;
  }
}
