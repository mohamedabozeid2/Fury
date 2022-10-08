import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/helper.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.getScreenHeight(context: context),
      width: Helper.getScreenWidth(context: context),
      child: CachedNetworkImage(
        imageUrl:
            "https://cdna.artstation.com/p/assets/images/images/034/393/132/large/sajal-kr-chand-1371.jpg?1612190623",
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
            ),
          ),
        ),
        placeholder: (context, url) => Center(
          child: Container()
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
