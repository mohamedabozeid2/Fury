import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/helper.dart';
import '../../controller/news_cubit/news_cubit.dart';
import '../../controller/news_cubit/news_states.dart';
import 'widgets/hottest_news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    NewsCubit.get(context).getMoviesNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Helper.maxWidth*0.05, vertical: Helper.maxHeight *0.08),
              child: Column(
                children: [
                  Text('Hottest News', style: Theme.of(context).textTheme.bodyText2,),
                  HottestNews(),
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
