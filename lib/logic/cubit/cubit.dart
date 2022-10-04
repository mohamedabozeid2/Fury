import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/api/dio_helper.dart';
import 'package:movies_application/core/api/end_points.dart';
import 'package:movies_application/logic/cubit/states.dart';

class MoviesCubit extends Cubit<MoviesStates>{
  MoviesCubit() : super(MoviesInitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);


  void getData(){
    DioHelper.getData(url: EndPoints.popular,query: {
      'api_key' : DioHelper.apiKey
    }).then((value){
      print(value.data);
    }).catchError((error){
      print('Error in get data ===> ${error.toString()}');
    });



  }




}