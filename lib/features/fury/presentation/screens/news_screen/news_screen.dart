import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/features/fury/presentation/screens/news_screen/widgets/explore/explore.dart';
import 'package:movies_application/features/fury/presentation/screens/news_screen/widgets/general_news/general_news.dart';
import 'package:movies_application/features/fury/presentation/screens/news_screen/widgets/horizontal_news_item_builder.dart';

import '../../../../../core/utils/helper.dart';
import '../../controller/news_cubit/news_cubit.dart';
import '../../controller/news_cubit/news_states.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ScrollController scrollController = ScrollController();
  bool isLoadMoreRunning = false;

  @override
  void initState() {
    super.initState();
    // scrollController.addListener(() {
    //   setState(() {
    //     if (scrollController.position.atEdge &&
    //         scrollController.position.pixels != 0) {
    //       if (isLoadMoreRunning) {
    //         debugPrint('Loading');
    //       } else {
    //         NewsCubit.get(context).loadMoreNews(hasMorePage: true,
    //           isLoadingMore: false,
    //           category: NewsCategoryKeys.general,
    //           page: NewsCubit
    //               .get(context)
    //               .currentGeneralPage,);
    //       }
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      buildWhen: (previous, current) =>
          current is GetNewsLoadingState || current is GetNewsSuccessState,
      listener: (context, state) {
        if (state is LoadMoreNewsLoadingState) {
          isLoadMoreRunning = true;
        } else if (state is LoadMoreNewsSuccessState) {
          isLoadMoreRunning = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return state is GetNewsLoadingState
                  ? Center(
                      child: AdaptiveIndicator(
                      os: Components.getOS(),
                      color: AppColors.mainColor,
                    ))
                  : Padding(
                      padding: EdgeInsets.only(
                        top: Helper.maxHeight * 0.1,
                        left: Helper.maxHeight * 0.015,
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.hottestNews,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(
                              height: Helper.maxHeight * 0.03,
                            ),
                            HorizontalNewsItemBuilder(
                                newsData:
                                    NewsCubit.get(context).moviesNewsList),
                            SizedBox(
                              height: Helper.maxHeight * 0.03,
                            ),
                            Text(
                              AppStrings.explore,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(
                              height: Helper.maxHeight * 0.03,
                            ),
                            Explore(),
                            const GeneralNews(),
                          ],
                        ),
                      ));
            },
          ),
        );
      },
    );
  }
}
