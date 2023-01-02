import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/presentation/screens/my_movies_screen/widgets/favorite_screen.dart';
import 'package:movies_application/features/fury/presentation/screens/my_movies_screen/widgets/watch_later_screen.dart';

import '../../../../../core/utils/Colors.dart';
import '../../../../../core/utils/app_values.dart';

class MyMoviesScreen extends StatelessWidget {
  const MyMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: AppSize.s5,
          bottom: TabBar(
            indicatorWeight: AppSize.s4,
            indicatorColor: AppColors.mainColor,
            tabs: const [
              Tab(
                icon: Icon(Icons.favorite),
                child: Text(AppStrings.favorite),
              ),
              Tab(
                icon: Icon(Icons.movie_filter_outlined),
                child: Text(AppStrings.watchLater),
              ),
            ],
          ),
        ),
        body: const TabBarView(
            children: [
            FavoriteScreen(),
              WatchLaterScreen(),
        ])
      ),
    );
  }
}
