import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/api/news_dio_helper.dart';
import 'package:movies_application/logic/news_cubit/news_states.dart';

import '../../features/fury/domain/entities/news_item.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  NewsItem? moviesNews;
  String prevMonth = DateTime(DateTime.now().year,DateTime.now().month-1, DateTime.now().day).toString();
  void getMoviesNews(){
    NewsDioHelper.getData(url: EndPoints.newsEverything,query: {
      "q" : "Movies",
      "from" : prevMonth,
      'sortBy' : 'publishedAt',
      'apiKey' : NewsDioHelper.apiKey,
    }).then((value){
      moviesNews = NewsItem.fromJson(value.data);
    });
  }

}