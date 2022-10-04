import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/helper.dart';
import 'adaptive_indicator.dart';

class CachedImage extends StatelessWidget {
  final String image;
  Color circularColor;
  final double height;
  final double width;
  BoxFit fit;
  CachedImage({required this.image, this.circularColor = Colors.blue, required this.height, required this.width, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      width: width,
      height: height,
      key: UniqueKey(),
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(child: AdaptiveIndicator(os: Platform.operatingSystem, color: circularColor,)),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
