import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_states.dart';
import 'package:movies_application/features/fury/presentation/screens/search_screen/widgets/search_item_builder.dart';

import '../../../../../core/widgets/icon_button.dart';
import '../../../../../core/widgets/text_field.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: AppSize.s50,
              left: AppSize.s20,
              right: AppSize.s20,
              bottom: AppSize.s10,
            ),
            child: Row(
              children: [
                DefaultIconButton(
                  fun: () {
                    Navigator.pop(context);
                  },
                  size: AppSize.s30,
                  color: AppColors.mainColor,
                  icon: Icons.arrow_back_ios_sharp,
                ),
                SizedBox(
                  width: AppSize.s6,
                ),
                Expanded(
                  child: DefaultTextField(
                    controller: searchController,
                    type: TextInputType.text,
                    context: context,
                    label: AppStrings.search,
                    onChangeFunction: (value) {
                      print("CHANGEEEEEEEEEED");
                      MoviesCubit.get(context)
                          .searchMovie(searchContent: value, page: 1);
                    },
                    suffixIcon: Icons.search,
                    fillColor: Colors.white,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: AppColors.mainColor),
                    borderRadius: AppSize.s5,
                    contentStyle:
                        Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: AppColors.mainColor,
                            ),
                    paddingInside: AppSize.s5,
                  ),
                ),
              ],
            ),
          ),
          BlocConsumer<MoviesCubit, MoviesStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return state is SearchMoviesLoadingState
                  ? AdaptiveIndicator(
                      os: Components.getOS(),
                      color: AppColors.mainColor,
                    )
                  : Expanded(
                      child: MoviesCubit.get(context).searchMovies != null
                          ? Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return SearchItemBuilder(
                                          movie: MoviesCubit.get(context)
                                              .searchMovies!
                                              .moviesList[index],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: AppSize.s3,
                                        );
                                      },
                                      itemCount: MoviesCubit.get(context)
                                          .searchMovies!
                                          .moviesList
                                          .length),
                                )
                              ],
                            )
                          : Container(),
                    );
            },
          )
        ],
      ),
    );
  }
}
