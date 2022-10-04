import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/features/fury/presentation/screens/home_screen/widgets/search_bar.dart';

class ForegroundWidget extends StatelessWidget {
  const ForegroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, Helper.getScreenHeight(context: context)*0.02, 0, 0),
      width: Helper.getScreenWidth(context: context)*0.9,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SearchBar(),
        ],
      ),
    );
  }
}
