import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/features/fury/presentation/controller/news_cubit/news_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/news_cubit/news_states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../core/utils/app_values.dart';
import '../../../../../../../../core/utils/helper.dart';
import '../../../../../../../../core/utils/strings.dart';
import '../../../../../../../../core/widgets/cached_image.dart';
import '../../../../../../domain/entities/news_item.dart';

class NewsCategoryDetails extends StatefulWidget {
  final String title;

  const NewsCategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<NewsCategoryDetails> createState() => _NewsCategoryDetailsState();
}

class _NewsCategoryDetailsState extends State<NewsCategoryDetails> {
  ScrollController scrollController = ScrollController();
  final double newsItemPadding = AppSize.s10;
  final double newsItemHeight = Helper.maxHeight * 0.15;
  final double newsItemMargin = AppSize.s10;
  final double newsItemDivider = Helper.maxHeight * 0.02;
  late NewsItem newsData;
  late double totalNewsItemHeight;
  late double totalNewsItemWidth;

  @override
  void initState() {
    totalNewsItemHeight =
        newsItemHeight + (newsItemPadding * 2) + newsItemDivider;
    totalNewsItemWidth = Helper.maxWidth - (newsItemMargin * 2);

    if (widget.title == AppStrings.business) {
      newsData = NewsCubit.get(context).businessNews!;
    } else if (widget.title == AppStrings.sports) {
      newsData = NewsCubit.get(context).sportsNews!;
    } else if (widget.title == AppStrings.health) {
      newsData = NewsCubit.get(context).healthNews!;
    } else if (widget.title == AppStrings.science) {
      newsData = NewsCubit.get(context).scienceNews!;
    } else if (widget.title == AppStrings.technology) {
      newsData = NewsCubit.get(context).technologyNews!;
    }
    scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Padding(
            padding: EdgeInsets.all(newsItemMargin),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      final double itemPosition = index * totalNewsItemHeight;
                      final double difference =
                          scrollController.offset - itemPosition;
                      final double percent =
                          1 - (difference / totalNewsItemHeight);
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
                          child: generalNewsItem(index: index),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: newsItemDivider,
                      );
                    },
                    itemCount: newsData.articles.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget generalNewsItem({required int index}) {
    String date = newsData.articles[index].publishAt;
    date = date.substring(0, 10);
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(newsData.articles[index].url));
      },
      child: Container(
        padding: EdgeInsets.all(newsItemPadding),
        decoration: BoxDecoration(
          color: AppColors.mainColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s20)),
              child: CachedImage(
                image: newsData.articles[index].urlToImage,
                height: newsItemHeight,
                width: Helper.maxWidth * 0.5,
                circularColor: AppColors.mainColor,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: Helper.maxWidth * 0.02,
            ),
            Expanded(
              child: SizedBox(
                height: newsItemHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      newsData.articles[index].title,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          date,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: AppColors.whiteButtonText),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
