import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/constants.dart';
import 'features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'features/fury/presentation/controller/home_cubit/home_states.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            title: Text("Test"),
          ),
          body: Column(
            children: [
              MaterialButton(
                height: 100,
                color: Colors.white,
                onPressed: () {
                  MoviesCubit.get(context).getPopularMovies().then((value){
                    value.fold((l){}
                        , (r){
                      popularMovies = r;
                        });
                  });
                },
                child: Text('Test'),
              ),
              MaterialButton(
                height: 100,
                color: Colors.white,
                onPressed: () {
                  print(popularMovies!.moviesList[0]);
                },
                child: Text('Test2'),
              ),
            ],
          ),
        );
      },
    );
  }

}
