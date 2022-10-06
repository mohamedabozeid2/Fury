import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/api/dio_helper.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/core/network/network.dart';
import 'package:movies_application/logic/home_layout/home_states.dart';
import '../../core/utils/constants.dart';
import '../../features/fury/data/models/popular_movies_model.dart';
import '../../features/fury/data/models/user_model.dart';

class MoviesCubit extends Cubit<MoviesStates>{
  MoviesCubit() : super(MoviesInitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);


  List<PopularMoviesModel> popularMovies = [];

  void getUserData({
    required String userID,
    bool isMainUser = true,
  }) {
    emit(FuryGetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) {
      userModel = FuryUserModel.fromJson(value.data()!);
      emit(FuryGetUserDataSuccessState());
    }).catchError((error) {
      print("Error ===> ${error.toString()}");
      emit(FuryGetUserDataErrorState());
    });
  }


  void getPopularMovies(){
    emit(FuryGetPopularMoviesLoadingState());
    CheckConnection.checkConnection().then((value){
      internetConnection = value;

      if(value == true){
        DioHelper.getData(url: EndPoints.popular,query: {
          'api_key' : DioHelper.apiKey
        }).then((value){
          popularMovies.add(PopularMoviesModel.fromJson(value.data));
          emit(FuryGetPopularMoviesSuccessState());
        }).catchError((error){
          print('Error in get data ===> ${error.toString()}');
          emit(FuryGetPopularMoviesErrorState());
        });
      }
    });

    }
  }


