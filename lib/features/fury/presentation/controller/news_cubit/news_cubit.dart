import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/constants.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/keys/news_category_keys.dart';
import '../../../data/models/single_news_model.dart';
import '../../../domain/entities/news_item.dart';
import '../../../domain/usecases/get_business_news.dart';
import '../../../domain/usecases/get_general_news.dart';
import '../../../domain/usecases/get_health_news.dart';
import '../../../domain/usecases/get_movies_news.dart';
import '../../../domain/usecases/get_science_news.dart';
import '../../../domain/usecases/get_sports_news.dart';
import '../../../domain/usecases/get_technology_news.dart';
import '../../../domain/usecases/load_more_news.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  final GetMoviesNewsUseCase getMoviesNewsUseCase;
  final GetBusinessNewsUseCase getBusinessNewsUseCase;
  final GetGeneralNewsUseCase getGeneralNewsUseCase;
  final GetHealthNewsUseCase getHealthNewsUserCase;
  final GetScienceNewsUseCase getScienceNewsUseCase;
  final GetSportsNewsUseCase getSportsNewsUserCase;
  final GetTechnologyNewsUseCase getTechnologyNewsUseCase;
  final LoadMoreNewsUseCase loadMoreNewsUseCase;

  NewsCubit(
    this.getMoviesNewsUseCase,
    this.getBusinessNewsUseCase,
    this.getGeneralNewsUseCase,
    this.getHealthNewsUserCase,
    this.getSportsNewsUserCase,
    this.getTechnologyNewsUseCase,
    this.getScienceNewsUseCase,
    this.loadMoreNewsUseCase,
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
                // moviesNews = r;
                for (var element in r.articles) {
                  moviesNewsList.add(element);
                }
                emit(GetNewsSuccessState());
              });
            } else if (i == 1) {
              value[i].fold((l) {
                emit(GetBusinessNewsErrorState(error: l.message));
              }, (r) {
                for (var element in r.articles) {
                  businessNewsList.add(element);
                }
                // businessNews = r;
              });
            } else if (i == 2) {
              value[i].fold((l) {
                emit(GetGeneralNewsErrorState(error: l.message));
              }, (r) {
                // generalNews = r;
                for (var element in r.articles) {
                  generalNewsList.add(element);
                }
              });
            } else if (i == 3) {
              value[i].fold((l) {
                emit(GetHealthNewsErrorState(error: l.message));
              }, (r) {
                // healthNews = r;
                for (var element in r.articles) {
                  healthNewsList.add(element);
                }
              });
            } else if (i == 4) {
              value[i].fold((l) {
                emit(GetScienceNewsErrorState(error: l.message));
              }, (r) {
                // scienceNews = r;
                for (var element in r.articles) {
                  scienceNewsList.add(element);
                }
              });
            } else if (i == 5) {
              value[i].fold((l) {
                emit(GetSportsNewsErrorState(error: l.message));
              }, (r) {
                // sportsNews = r;
                for (var element in r.articles) {
                  sportsNewsList.add(element);
                }
              });
            } else if (i == 6) {
              value[i].fold((l) {
                emit(GetTechnologyNewsErrorState(error: l.message));
              }, (r) {
                // technologyNews = r;
                for (var element in r.articles) {
                  technologyNewsList.add(element);
                }
              });
            }
          }
          emit(GetNewsSuccessState());
        });
      }
    });
  }

  /////////  Movies News ///////////

  List<SingleNewsModel> moviesNewsList = [];

  Future<Either<Failure, NewsItem>> getMoviesNews() async {
    return await getMoviesNewsUseCase.execute();
  }

  /////////  Business News ///////////
  List<SingleNewsModel> businessNewsList = [];

  Future<Either<Failure, NewsItem>> getBusinessNews() async {
    return await getBusinessNewsUseCase.execute();
  }

  /////////  General News ///////////
  List<SingleNewsModel> generalNewsList = [];

  Future<Either<Failure, NewsItem>> getGeneralNews() async {
    return await getGeneralNewsUseCase.execute();
  }

  /////////  Health News ///////////
  List<SingleNewsModel> healthNewsList = [];

  Future<Either<Failure, NewsItem>> getHealthNews() async {
    return await getHealthNewsUserCase.execute();
  }

/////////  Science News ///////////
  List<SingleNewsModel> scienceNewsList = [];

  Future<Either<Failure, NewsItem>> getScienceNews() async {
    return await getScienceNewsUseCase.execute();
  }

/////////  Sports News ///////////
  List<SingleNewsModel> sportsNewsList = [];

  Future<Either<Failure, NewsItem>> getSportsNews() async {
    return await getSportsNewsUserCase.execute();
  }

/////////  Technology News ///////////
  List<SingleNewsModel> technologyNewsList = [];

  Future<Either<Failure, NewsItem>> getTechnologyNews() async {
    return await getTechnologyNewsUseCase.execute();
  }

  int currentMoviesPage = 1;
  int currentGeneralPage = 1;
  int currentBusinessPage = 1;
  int currentSportsPage = 1;
  int currentHealthPage = 1;
  int currentSciencePage = 1;
  int currentTechnologyPage = 1;

  void loadMoreNews({
    required bool hasMorePage,
    required bool isLoadingMore,
    required String category,
    required int page,
  }) async {
    emit(LoadMoreNewsLoadingState());
    final result =
        await loadMoreNewsUseCase.execute(category: category, page: page+1);
    result.fold((l) {
      emit(LoadMoreNewsErrorState(error: l.message));
    }, (r) {
      if (hasMorePage && !isLoadingMore) {
        isLoadingMore = true;
        if (category == NewsCategoryKeys.general) {
          currentGeneralPage++;
          for (var element in r.articles) {
            generalNewsList.add(element);
          }
        } else if (category == NewsCategoryKeys.movies) {
          currentMoviesPage++;
          for(var element in r.articles){
            moviesNewsList.add(element);
          }
        } else if (category == NewsCategoryKeys.technology) {
          currentTechnologyPage++;
          for(var element in r.articles){
            technologyNewsList.add(element);
          }
        } else if (category == NewsCategoryKeys.science) {
          currentSciencePage++;
          for(var element in r.articles){
            scienceNewsList.add(element);
          }
        } else if (category == NewsCategoryKeys.sports) {
          currentSportsPage++;
          for(var element in r.articles){
            sportsNewsList.add(element);
          }
        } else if (category == NewsCategoryKeys.business) {
          currentBusinessPage++;

          for(var element in r.articles){
            businessNewsList.add(element);
          }
        } else if (category == NewsCategoryKeys.health) {
          currentHealthPage++;
          for(var element in r.articles){
            healthNewsList.add(element);
          }
        }
      }
      emit(LoadMoreNewsSuccessState());
    });
  }
}
