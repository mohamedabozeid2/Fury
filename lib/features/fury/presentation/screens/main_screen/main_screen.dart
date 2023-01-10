import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/home_cubit/home_cubit.dart';
import '../../controller/home_cubit/home_states.dart';
import '../Layout/widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: BlocConsumer<MoviesCubit, MoviesStates>(
        buildWhen: (previous, current) => current is ChangeBotNavBarState,
        listener: (context, state){},
        builder: (context, state){
          return MoviesCubit.get(context)
              .screens[MoviesCubit.get(context).botNavCurrentIndex];
        },
      ),
    );
  }
}
