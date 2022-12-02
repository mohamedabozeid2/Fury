import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/constants.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/news_item.dart';
import '../../../domain/usecases/get_business_news.dart';
import '../../../domain/usecases/get_general_news.dart';
import '../../../domain/usecases/get_health_news.dart';
import '../../../domain/usecases/get_movies_news.dart';
import '../../../domain/usecases/get_science_news.dart';
import '../../../domain/usecases/get_sports_news.dart';
import '../../../domain/usecases/get_technology_news.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  final GetMoviesNewsUseCase getMoviesNewsUseCase;
  final GetBusinessNewsUseCase getBusinessNewsUseCase;
  final GetGeneralNewsUseCase getGeneralNewsUseCase;
  final GetHealthNewsUseCase getHealthNewsUserCase;
  final GetScienceNewsUseCase getScienceNewsUseCase;
  final GetSportsNewsUseCase getSportsNewsUserCase;
  final GetTechnologyNewsUseCase getTechnologyNewsUseCase;

  NewsCubit(
    this.getMoviesNewsUseCase,
    this.getBusinessNewsUseCase,
    this.getGeneralNewsUseCase,
    this.getHealthNewsUserCase,
    this.getSportsNewsUserCase,
    this.getTechnologyNewsUseCase,
    this.getScienceNewsUseCase,
  ) : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  String prevMonth = DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .toString();

  void getAllNews() async {
    emit(GetNewsLoadingState());
    CheckConnection.checkConnection().then((value) {
      internetConnection = value;
      if (value == true) {
        Future.wait([
          getMoviesNews(),
          getBusinessNews(),
          getGeneralNews(),
          getHealthNews(),
          getScienceNews(),
          getSportsNews(),
          getTechnologyNews(),
        ]).then((value) {
          for (int i = 0; i < value.length; i++) {
            if (i == 0) {
              value[i].fold((l) {
                emit(GetMoviesNewsErrorState(error: l.message));
              }, (r) {
                moviesNews = r;
                emit(GetNewsSuccessState());
              });
            } else if (i == 1) {
              value[i].fold((l) {
                emit(GetBusinessNewsErrorState(error: l.message));
              }, (r) {
                businessNews = r;
              });
            } else if (i == 2) {
              value[i].fold((l) {
                emit(GetGeneralNewsErrorState(error: l.message));
              }, (r) {
                generalNews = r;
              });
            } else if (i == 3) {
              value[i].fold((l) {
                emit(GetHealthNewsErrorState(error: l.message));
              }, (r) {
                healthNews = r;
              });
            } else if (i == 4) {
              value[i].fold((l) {
                emit(GetScienceNewsErrorState(error: l.message));
              }, (r) {
                scienceNews = r;
              });
            } else if (i == 5) {
              value[i].fold((l) {
                emit(GetSportsNewsErrorState(error: l.message));
              }, (r) {
                sportsNews = r;
              });
            } else if (i == 6) {
              value[i].fold((l) {
                emit(GetTechnologyNewsErrorState(error: l.message));
              }, (r) {
                technologyNews = r;
              });
            }
          }
          emit(GetNewsSuccessState());
        });
      }
    });
  }

  /////////  Movies News ///////////
  NewsItem? moviesNews;

  Future<Either<Failure, NewsItem>> getMoviesNews() async {
    return await getMoviesNewsUseCase.execute();
  }

  /////////  Business News ///////////
  NewsItem? businessNews;

  Future<Either<Failure, NewsItem>> getBusinessNews() async {
    return await getBusinessNewsUseCase.execute();
  }

  /////////  General News ///////////
  NewsItem? generalNews;

  Future<Either<Failure, NewsItem>> getGeneralNews() async {
    return await getGeneralNewsUseCase.execute();
  }

  /////////  Health News ///////////
  NewsItem? healthNews;

  Future<Either<Failure, NewsItem>> getHealthNews() async {
    return await getHealthNewsUserCase.execute();
  }

/////////  Science News ///////////
  NewsItem? scienceNews;

  Future<Either<Failure, NewsItem>> getScienceNews() async {
    return await getScienceNewsUseCase.execute();
  }

/////////  Sports News ///////////
  NewsItem? sportsNews;

  Future<Either<Failure, NewsItem>> getSportsNews() async {
    return await getSportsNewsUserCase.execute();
  }

/////////  Technology News ///////////
  NewsItem? technologyNews;

  Future<Either<Failure, NewsItem>> getTechnologyNews() async {
    return await getTechnologyNewsUseCase.execute();
  }
}
