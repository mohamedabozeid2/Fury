import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/features/fury/data/models/single_news_model.dart';
import 'package:movies_application/features/fury/presentation/controller/news_cubit/news_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/news_cubit/news_states.dart';
import 'package:movies_application/features/fury/presentation/screens/news_screen/widgets/vertical_news_item_builder.dart';

import '../../../../../../../../core/utils/app_values.dart';
import '../../../../../../../../core/utils/helper.dart';
import '../../../../../../../../core/utils/strings.dart';

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
  late List<SingleNewsModel> newsData;
  late double totalNewsItemHeight;
  late double totalNewsItemWidth;
  late int page;

  @override
  void initState() {
    totalNewsItemHeight =
        newsItemHeight + (newsItemPadding * 2) + newsItemDivider;
    totalNewsItemWidth = Helper.maxWidth - (newsItemMargin * 2);

    if (widget.title == AppStrings.business) {
      page = NewsCubit.get(context).currentBusinessPage;
      newsData = NewsCubit.get(context).businessNewsList;
    } else if (widget.title == AppStrings.sports) {
      page = NewsCubit.get(context).currentSportsPage;
      newsData = NewsCubit.get(context).sportsNewsList;
    } else if (widget.title == AppStrings.health) {
      page = NewsCubit.get(context).currentHealthPage;
      newsData = NewsCubit.get(context).healthNewsList;
    } else if (widget.title == AppStrings.science) {
      page = NewsCubit.get(context).currentSciencePage;
      newsData = NewsCubit.get(context).scienceNewsList;
    } else if (widget.title == AppStrings.technology) {
      page = NewsCubit.get(context).currentTechnologyPage;
      newsData = NewsCubit.get(context).technologyNewsList;
    } else {
      page = NewsCubit.get(context).currentGeneralPage;
      newsData = NewsCubit.get(context).generalNewsList;
    }
    // scrollController.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      buildWhen: (previous, current) =>
          current is LoadMoreNewsLoadingState ||
          current is LoadMoreNewsSuccessState,
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
                  child: NotificationListener<ScrollUpdateNotification>(
                    onNotification: (value) {
                      setState(() {});
                      if (scrollController.position.atEdge &&
                          scrollController.position.pixels != 0) {
                        if (state is LoadMoreNewsLoadingState) {
                          debugPrint("Loading");
                        } else {
                          NewsCubit.get(context).loadMoreNews(
                              hasMorePage: true,
                              isLoadingMore: false,
                              category: widget.title,
                              page: page);
                        }
                      }
                      return true;
                    },
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
                            child: VerticalNewsItemBuilder(
                              newsData: newsData,
                              index: index,
                              title: widget.title,
                              newsItemHeight: newsItemHeight,
                              newsItemPadding: newsItemPadding,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: newsItemDivider,
                        );
                      },
                      itemCount: newsData.length,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
