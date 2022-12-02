import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/features/fury/domain/entities/news_item.dart';
import 'package:movies_application/features/fury/presentation/controller/news_cubit/news_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/news_cubit/news_states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../core/utils/Colors.dart';
import '../../../../../../../../core/utils/app_values.dart';
import '../../../../../../../../core/utils/helper.dart';
import '../../../../../../../../core/widgets/cached_image.dart';

class NewsItemBuilder extends StatelessWidget {
  final int index;
  final double newsItemHeight;
  final double newsItemWidth;
  final double newsPadding;
  final NewsItem newsData;

  const NewsItemBuilder({
    Key? key,
    required this.index,
    required this.newsPadding,
    required this.newsItemWidth,
    required this.newsItemHeight,
    required this.newsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return newsData.articles[index].urlToImage == null
            ? Container()
            : GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(
                      NewsCubit.get(context).moviesNews!.articles[index].url));
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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Helper.maxHeight * 0.02)),
                            child: CachedImage(
                              circularColor: AppColors.mainColor,
                              fit: BoxFit.cover,
                              image: NewsCubit.get(context)
                                  .moviesNews!
                                  .articles[index]
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
                              NewsCubit.get(context)
                                      .moviesNews!
                                      .articles[index]
                                      .title ??
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
                                    NewsCubit.get(context)
                                            .moviesNews!
                                            .articles[index]
                                            .author ??
                                        "Author is unknown",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
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
                          child: Text(NewsCubit.get(context)
                              .moviesNews!
                              .articles[index]
                              .source),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
