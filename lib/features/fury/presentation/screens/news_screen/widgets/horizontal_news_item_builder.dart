import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/keys/news_category_keys.dart';
import 'package:movies_application/features/fury/data/models/single_news_model.dart';
import 'package:movies_application/features/fury/presentation/controller/news_cubit/news_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/news_cubit/news_states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../core/utils/Colors.dart';
import '../../../../../../../../core/utils/app_values.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../core/utils/helper.dart';
import '../../../../../../../../core/widgets/cached_image.dart';

class HorizontalNewsItemBuilder extends StatefulWidget {
  final List<SingleNewsModel> newsData;

  const HorizontalNewsItemBuilder({Key? key, required this.newsData})
      : super(key: key);

  @override
  State<HorizontalNewsItemBuilder> createState() =>
      _HorizontalNewsItemBuilderState();
}

class _HorizontalNewsItemBuilderState extends State<HorizontalNewsItemBuilder> {
  final ScrollController scrollController = ScrollController();
  double newsItemWidth = Helper.maxWidth * 0.7;
  double newsItemHeight = Helper.maxHeight * 0.4;
  double newsPadding = AppSize.s10;
  double newsDivider = Helper.maxWidth * 0.04;
  late double newsSize;

  @override
  void initState() {
    newsSize = newsItemWidth + newsDivider + (2 * newsPadding);
    // scrollController.addListener(() {
    //
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      buildWhen: (previous, current) =>
          current is LoadMoreNewsSuccessState ||
          current is LoadMoreNewsLoadingState,
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          height: newsItemHeight,
          child: Row(
            children: [
              Expanded(
                child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: (value) {
                    setState(() {});
                    if (scrollController.position.atEdge &&
                        scrollController.position.pixels != 0) {
                      if (state is LoadMoreNewsLoadingState) {
                        debugPrint('Loading');
                      } else {
                        NewsCubit.get(context).loadMoreNews(
                          hasMorePage: true,
                          isLoadingMore: false,
                          category: NewsCategoryKeys.movies,
                          page: NewsCubit.get(context).currentMoviesPage,
                        );
                      }
                      return true;
                    } else {
                      return false;
                    }
                  },
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
                            child: newsItemBuilder(index: index)),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: newsDivider,
                      );
                    },
                    itemCount: NewsCubit.get(context).moviesNewsList.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget newsItemBuilder({required int index}) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(NewsCubit.get(context).moviesNewsList[index].url));
      },
      child: Container(
        padding: EdgeInsets.all(newsPadding),
        decoration: BoxDecoration(
            color: AppColors.mainColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(AppSize.s20)),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: newsItemHeight * 0.6,
                  width: newsItemWidth,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Helper.maxHeight * 0.02)),
                  child: widget.newsData[index].urlToImage == null
                      ? Image.asset(
                          ImageAssets.emptyNews,
                          fit: BoxFit.cover,
                        )
                      : CachedImage(
                          circularColor: AppColors.mainColor,
                          fit: BoxFit.cover,
                          image: NewsCubit.get(context)
                              .moviesNewsList[index]
                              .urlToImage,
                          height: newsItemHeight * 0.6,
                          width: newsItemWidth,
                        ),
                ),
                SizedBox(
                  height: newsItemHeight * 0.05,
                ),
                SizedBox(
                  height: newsItemHeight * 0.2,
                  width: newsItemWidth,
                  child: Text(
                    NewsCubit.get(context).moviesNewsList[index].title ??
                        "No Title",
                    style: Theme.of(context).textTheme.subtitle1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: newsItemHeight * 0.05,
                  width: newsItemWidth,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          NewsCubit.get(context).moviesNewsList[index].author ??
                              "Author is unknown",
                          style: Theme.of(context).textTheme.subtitle2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        size: AppSize.s26,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
            Card(
              margin: EdgeInsets.all(AppSize.s15),
              color: AppColors.mainColor,
              child: Padding(
                padding: EdgeInsets.all(AppSize.s3),
                child:
                    Text(NewsCubit.get(context).moviesNewsList[index].source),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
