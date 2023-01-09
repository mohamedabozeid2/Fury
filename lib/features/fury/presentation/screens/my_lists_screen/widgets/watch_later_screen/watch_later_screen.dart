import 'package:flutter/cupertino.dart';

import '../vertical_movies_list/vertical_movies_list.dart';

class WatchLaterScreen extends StatelessWidget {
  const WatchLaterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(child: VerticalMoviesList(favoriteOrWatchList: false,));

  }
}
