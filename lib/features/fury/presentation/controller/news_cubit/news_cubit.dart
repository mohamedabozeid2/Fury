import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/news_item.dart';
import '../../../domain/usecases/get_movies_news.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  final GetMoviesNewsUserCase getMoviesNewsUserCase;
  NewsCubit(this.getMoviesNewsUserCase) : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  NewsItem? moviesNews;
  String prevMonth = DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .toString();

  void getMoviesNews() async {

    // BaseMoviesNewsRemoteDataSource baseMoviesNewsRemoteDataSource =
    //     MoviesNewsRemoteDataSource();
    //
    // BaseMoviesNewsRepository baseMoviesNewsRepository =
    //     MoviesNewsRepository(baseMoviesNewsRemoteDataSource);

    final result = await getMoviesNewsUserCase.execute();

    result.fold((l){

    }, (r){
      moviesNews = r;
    });
    print(moviesNews!.articles[0].title);
  }

// void getMoviesNews(){
//   NewsDioHelper.getData(url: EndPoints.newsEverything,query: {
//     "q" : "Movies",
//     "from" : prevMonth,
//     'sortBy' : 'publishedAt',
//     'apiKey' : NewsDioHelper.apiKey,
//   }).then((value){
//     moviesNews = NewsItem.fromJson(value.data);
//   });
// }
}
