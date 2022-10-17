import 'package:flutter/material.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/helper.dart';
import '../../../../../../core/widgets/cached_image.dart';

class AppBarMovieBuilder extends StatelessWidget {
  final String image;

  AppBarMovieBuilder({required this.image});

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      titlePadding: EdgeInsets.zero,
      background: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () {},
              child: CachedImage(
                fit: BoxFit.cover,
                circularColor: AppColors.mainColor,
                image: image,
                width: Helper.getScreenWidth(context: context),
                height: Helper.getScreenHeight(context: context) * 0.75,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Helper.getScreenHeight(context: context)*0.012),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.only(topRight: Radius.circular(20.0),topLeft: Radius.circular(20.0))
            ),
            // padding: EdgeInsets.symmetric(
            //     horizontal: Helper.getScreenWidth(context: context) * 0.06,
            //     vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                bottomBarItemBuilder(
                    icon: Icons.add, title: 'Later', context: context),
                bottomBarItemBuilder(
                    icon: Icons.favorite,
                    title: 'Favorite',
                    context: context),
                bottomBarItemBuilder(
                    icon: Icons.info, title: 'Info', context: context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bottomBarItemBuilder(
      {required IconData icon,
      required String title,
      required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white,size: 16),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.white),
        )
      ],
    );
  }
}
