import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/adaptive_indicator.dart';
import 'package:movies_application/features/fury/presentation/screens/news_screen/widgets/explore/explore.dart';

import '../../../../../core/utils/helper.dart';
import '../../controller/news_cubit/news_cubit.dart';
import '../../controller/news_cubit/news_states.dart';
import 'widgets/hottest_news/hottest_news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
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
                        bottom: Helper.maxHeight * 0.08,
                        left: Helper.maxHeight * 0.015,
                      ),
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
                          const HottestNews(),
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
                        ],
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}
