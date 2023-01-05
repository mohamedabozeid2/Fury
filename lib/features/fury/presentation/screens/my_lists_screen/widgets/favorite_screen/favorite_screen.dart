import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_cubit.dart';
import 'package:movies_application/features/fury/presentation/controller/home_cubit/home_states.dart';
import 'package:movies_application/features/fury/presentation/screens/my_lists_screen/widgets/vertical_movies_list/vertical_movies_list.dart';

import '../../../../../../../core/utils/constants.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      buildWhen: (previous, current) => current is AddToFavoriteSuccessState,
      listener: (context, state) {},
      builder: (context, state) {
        print(favoriteMovies!.moviesList[0].title);
        print("DONE");
        return const SingleChildScrollView(child: VerticalMoviesList());
      },
    );
  }
}
