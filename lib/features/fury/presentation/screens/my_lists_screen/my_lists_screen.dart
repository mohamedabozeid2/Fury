import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/presentation/screens/my_lists_screen/widgets/vertical_movies_list/vertical_movies_list.dart';

import '../../../../../core/utils/app_values.dart';
import '../../../../../core/widgets/drawer_icon_button.dart';

class MyListsScreen extends StatelessWidget {
  const MyListsScreen({super.key});

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
      body: Column(
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
          const Expanded(child: VerticalMoviesList()),
        ],
      ),
    );
  }
}
