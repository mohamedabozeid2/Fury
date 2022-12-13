import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_states.dart';

import '../../../../../core/widgets/icon_button.dart';
import '../../../../../core/widgets/text_field.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: AppSize.s50,
          left: AppSize.s20,
          right: AppSize.s20,
        ),
        child: Column(
          children: [
            Row(
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
                    sufIconFun: () {},
                    paddingInside: AppSize.s5,
                  ),
                ),
              ],
            ),
            BlocConsumer<MoviesCubit, MoviesStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                child: Text("SEARCH"),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox();
                            },
                            itemCount: 2),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
