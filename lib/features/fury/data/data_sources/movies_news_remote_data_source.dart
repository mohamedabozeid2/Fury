import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/api/news_dio_helper.dart';
import 'package:movies_application/core/error/exception.dart';
import 'package:movies_application/core/keys/news_category_keys.dart';
import 'package:movies_application/core/network/news_error_message_model.dart';

import '../models/news_item_model.dart';

abstract class BaseMoviesNewsRemoteDataSource {
  Future<MoviesNewsModel> getMoviesNews();

  Future<MoviesNewsModel> getBusinessNews();

  Future<MoviesNewsModel> getGeneralNews();

  Future<MoviesNewsModel> getHealthNews();

  Future<MoviesNewsModel> getScienceNews();

  Future<MoviesNewsModel> getSportsNews();

  Future<MoviesNewsModel> getTechnologyNews();

  Future<MoviesNewsModel> loadMoreNews({required String category, required int page});
}

class MoviesNewsRemoteDataSource extends BaseMoviesNewsRemoteDataSource {
  String prevMonth = DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .toString();

  @override
  Future<MoviesNewsModel> getMoviesNews() async {
    final response =
        await NewsDioHelper.getData(url: EndPoints.newsTopHeadline, query: {
      "country": "us",
      "category": NewsCategoryKeys.movies,
      "apiKey": NewsDioHelper.apiKey,
    });
    if (response.statusCode == 200) {
      return MoviesNewsModel.fromJson(response.data);
    } else {
      throw NewsServerException(
        newsErrorMessageModel: NewsErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesNewsModel> getBusinessNews() async {
    final response =
        await NewsDioHelper.getData(url: EndPoints.newsTopHeadline, query: {
      "country": "us",
      "category": NewsCategoryKeys.business,
      "apiKey": NewsDioHelper.apiKey,
    });
    if (response.statusCode == 200) {
      return MoviesNewsModel.fromJson(response.data);
    } else {
      throw NewsServerException(
        newsErrorMessageModel: NewsErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesNewsModel> getGeneralNews() async {
    final response =
        await NewsDioHelper.getData(url: EndPoints.newsTopHeadline, query: {
      "country": "us",
      "category": NewsCategoryKeys.general,
      "apiKey": NewsDioHelper.apiKey,
    });
    if (response.statusCode == 200) {
      return MoviesNewsModel.fromJson(response.data);
    } else {
      throw NewsServerException(
        newsErrorMessageModel: NewsErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesNewsModel> getHealthNews() async {
    final response =
        await NewsDioHelper.getData(url: EndPoints.newsTopHeadline, query: {
      "country": "us",
      "category": NewsCategoryKeys.health,
      "apiKey": NewsDioHelper.apiKey,
    });
    if (response.statusCode == 200) {
      return MoviesNewsModel.fromJson(response.data);
    } else {
      throw NewsServerException(
        newsErrorMessageModel: NewsErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesNewsModel> getScienceNews() async {
    final response =
        await NewsDioHelper.getData(url: EndPoints.newsTopHeadline, query: {
      "country": "us",
      "category": NewsCategoryKeys.science,
      "apiKey": NewsDioHelper.apiKey,
    });
    if (response.statusCode == 200) {
      return MoviesNewsModel.fromJson(response.data);
    } else {
      throw NewsServerException(
        newsErrorMessageModel: NewsErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesNewsModel> getSportsNews() async {
    final response =
        await NewsDioHelper.getData(url: EndPoints.newsTopHeadline, query: {
      "country": "us",
      "category": NewsCategoryKeys.sports,
      "apiKey": NewsDioHelper.apiKey,
    });
    if (response.statusCode == 200) {
      return MoviesNewsModel.fromJson(response.data);
    } else {
      throw NewsServerException(
        newsErrorMessageModel: NewsErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesNewsModel> getTechnologyNews() async {
    final response =
        await NewsDioHelper.getData(url: EndPoints.newsTopHeadline, query: {
      "country": "us",
      "category": NewsCategoryKeys.technology,
      "apiKey": NewsDioHelper.apiKey,
    });
    if (response.statusCode == 200) {
      return MoviesNewsModel.fromJson(response.data);
    } else {
      throw NewsServerException(
        newsErrorMessageModel: NewsErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MoviesNewsModel> loadMoreNews({
    required String category,
    required int page,
  }) async {
    final response =
        await NewsDioHelper.getData(url: EndPoints.newsTopHeadline, query: {
      "country": "us",
      "category": category,
      'page': '$page',
      "apiKey": NewsDioHelper.apiKey,
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
