import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/keys/news_category_keys.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/assets_manager.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/features/fury/presentation/controller/news_cubit/news_states.dart';
import 'package:movies_application/features/fury/presentation/screens/news_screen/widgets/explore/widgets/news_category_details.dart';

import '../../../../../../../core/utils/helper.dart';
import '../../../../controller/news_cubit/news_cubit.dart';

class Explore extends StatelessWidget {
  final List<String> images = [
    ImageAssets.business,
    ImageAssets.sports,
    ImageAssets.health,
    ImageAssets.science,
    ImageAssets.technologyImage,
  ];
  final List<String> titles = [
    NewsCategoryKeys.business,
    NewsCategoryKeys.sports,
    NewsCategoryKeys.health,
    NewsCategoryKeys.science,
    NewsCategoryKeys.technology,
  ];

  Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          height: Helper.maxHeight * 0.13,
          child: Row(
            children: [
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return exploreItemBuilder(
                      title: titles[index],
                      image: images[index],
                      context: context,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: AppSize.s20,
                    );
                  },
                  itemCount: images.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget exploreItemBuilder({
    required String image,
    required String title,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        Components.navigateTo(
            context,
            NewsCategoryDetails(
              title: title,
            ));
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: AppSize.s40,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s30),
                image: DecorationImage(
                  image: AssetImage(
                    image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: Helper.maxHeight * 0.005,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: AppColors.whiteButtonText,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}
