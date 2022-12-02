import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/features/fury/presentation/screens/news_screen/widgets/hottest_news/widgets/news_item_builder.dart';

import '../../../../controller/news_cubit/news_cubit.dart';
import '../../../../controller/news_cubit/news_states.dart';

class HottestNews extends StatefulWidget {
  const HottestNews({super.key});

  @override
  State<HottestNews> createState() => _HottestNewsState();
}

class _HottestNewsState extends State<HottestNews> {
  final ScrollController scrollController = ScrollController();
  double newsItemWidth = Helper.maxWidth * 0.7;
  double newsItemHeight = Helper.maxHeight * 0.4;
  double newsPadding = AppSize.s10;
  double newsDivider = Helper.maxWidth * 0.04;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        double newsSize = newsItemWidth + newsDivider + (2 * newsPadding);
        return SizedBox(
          height: newsItemHeight,
          child: Row(
            children: [
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final double itemPosition = index * newsSize;
                    final double difference =
                        scrollController.offset - itemPosition;
                    final double percent = 1 - (difference / newsSize);
                    double opacity = percent;
                    if (opacity > 1.0) opacity = 1.0;
                    if (opacity < 0.0) opacity = 0.0;
                    double scale = percent;
                    if (scale > 1.0) scale = 1.0;
                    if (scale < 0.0) scale = 0.0;
                    return Opacity(
                      opacity: opacity,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(scale, scale),
                        child: NewsItemBuilder(
                          index: index,
                          newsData: NewsCubit.get(context).moviesNews!,
                          newsItemHeight: newsItemHeight,
                          newsItemWidth: newsItemWidth,
                          newsPadding: newsPadding,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: newsDivider,
                    );
                  },
                  itemCount: NewsCubit.get(context).moviesNews!.articles.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
