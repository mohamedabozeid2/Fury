import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/api/news_dio_helper.dart';
import 'package:movies_application/core/error/exception.dart';
import 'package:movies_application/core/network/news_error_message_model.dart';

import '../models/news_item_model.dart';

abstract class BaseMoviesNewsRemoteDataSource{
  Future<MoviesNewsModel> getMoviesNews();
}

class MoviesNewsRemoteDataSource extends BaseMoviesNewsRemoteDataSource{
  String prevMonth = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .toString();
  @override
  Future<MoviesNewsModel> getMoviesNews() async {
    final response = await NewsDioHelper.getData(url: EndPoints.newsEverything, query: {
      "q" : "Movies",
      "from" : prevMonth,
      "sortBy" : "publishedAt",
      "apiKey" : NewsDioHelper.apiKey,
    });
    if (response.statusCode == 200) {
      return MoviesNewsModel.fromJson(response.data);
    } else {
      throw NewsServerException(
        newsErrorMessageModel: NewsErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
