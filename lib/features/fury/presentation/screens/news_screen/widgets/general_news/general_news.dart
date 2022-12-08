import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/features/fury/presentation/controller/news_cubit/news_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/news_cubit/news_states.dart';

import '../../../../../../../core/utils/app_values.dart';
import '../../../../../../../core/utils/helper.dart';
import '../vertical_news_item_builder.dart';

class GeneralNews extends StatefulWidget {
  const GeneralNews({Key? key}) : super(key: key);

  @override
  State<GeneralNews> createState() => _GeneralNewsState();
}

class _GeneralNewsState extends State<GeneralNews> {
  final double newsItemPadding = AppSize.s10;
  final double newsItemHeight = Helper.maxHeight * 0.15;
  final double newsItemDivider = Helper.maxHeight * 0.02;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state){
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return VerticalNewsItemBuilder(
                newsData:
                NewsCubit
                    .get(context)
                    .generalNewsList,
                index: index,
                newsItemHeight: newsItemHeight,
                newsItemPadding: newsItemPadding);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: newsItemDivider,
            );
          },
          itemCount:
          NewsCubit
              .get(context)
              .generalNewsList
              .length,
        );
      },
    );
  }
}
