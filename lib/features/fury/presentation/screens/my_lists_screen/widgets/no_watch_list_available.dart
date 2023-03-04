import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_application/core/utils/strings.dart';

class NoWatchListAvailableScreen extends StatelessWidget {
  const NoWatchListAvailableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/anims/movie.json'),
          const Text(AppStrings.noMovies),
        ],
      ),
    );
  }
}
