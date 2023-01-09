import 'package:flutter/material.dart';
import 'package:movies_application/features/fury/data/models/single_news_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/app_values.dart';
import '../../../../../../core/utils/assets_manager.dart';
import '../../../../../../core/widgets/cached_image.dart';

class VerticalNewsItemBuilder extends StatelessWidget {
  final String title;
  final List<SingleNewsModel> newsData;
  final int index;
  final double newsItemPadding;
  final double newsItemHeight;

  const VerticalNewsItemBuilder({
    Key? key,
    required this.newsData,
    this.title = 'general',
    required this.index,
    required this.newsItemHeight,
    required this.newsItemPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = newsData[index].publishAt;
    date = date.substring(0, 10);
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(newsData[index].url));
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
              height: newsItemHeight,
              width: AppSize.s150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s20)),
              child: newsData[index].urlToImage == null
                  ? Image.asset(
                ImageAssets.emptyNews,
                fit: BoxFit.cover,
              )
                  : CachedImage(
                image: newsData[index].urlToImage,
                height: newsItemHeight,
                width: AppSize.s150,
                circularColor: AppColors.mainColor,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: AppSize.s10,
            ),
            Expanded(
              child: SizedBox(
                height: newsItemHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      newsData[index].title,
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
