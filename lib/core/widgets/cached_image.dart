import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/Colors.dart';

import 'adaptive_indicator.dart';

class CachedImage extends StatelessWidget {
  final String image;
  final Color circularColor;
  final double height;
  final double width;
  final BoxFit fit;

  const CachedImage({
    super.key,
    required this.image,
    this.circularColor = Colors.blue,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      width: width,
      height: height,
      key: UniqueKey(),
      fit: fit,
      placeholder: (context, url) => Center(
          child: AdaptiveIndicator(
        os: Platform.operatingSystem,
        color: circularColor,
      )),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: AppColors.whiteButtonText),
    );
  }
}
