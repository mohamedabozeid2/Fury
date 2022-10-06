import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/api/dio_helper.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/core/utils/components.dart';
import 'package:movies_application/features/fury/presentation/cubit/states.dart';

import '../../../../core/utils/constants.dart';
import '../../data/models/popular_movies_model.dart';

class MoviesCubit extends Cubit<MoviesStates>{
  MoviesCubit() : super(MoviesInitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);


  List<PopularMoviesModel> popularMovies = [];


  void getPopularMovies(){
    emit(MoviesGetPopularMoviesLoadingState());
    CheckConnection.checkConnection().then((value){
      internetConnection = value;

      if(value == true){
        DioHelper.getData(url: EndPoints.popular,query: {
          'api_key' : DioHelper.apiKey
        }).then((value){
          popularMovies.add(PopularMoviesModel.fromJson(value.data));
          emit(MoviesGetPopularMoviesSuccessState());
        }).catchError((error){
          print('Error in get data ===> ${error.toString()}');
          emit(MoviesGetPopularMoviesErrorState());
        });
      }
    });

    }
  }


