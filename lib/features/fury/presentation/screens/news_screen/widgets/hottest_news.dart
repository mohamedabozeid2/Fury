import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/widgets/cached_image.dart';

import '../../../controller/news_cubit/news_cubit.dart';
import '../../../controller/news_cubit/news_states.dart';


class HottestNews extends StatefulWidget {
  const HottestNews({super.key});

  @override
  State<HottestNews> createState() => _HottestNewsState();
}

class _HottestNewsState extends State<HottestNews> {
  final ScrollController scrollController = ScrollController();
  double newsItemWidth = Helper.maxWidth * 0.7;
  double newsItemHeight = Helper.maxHeight * 0.25;
  double newsDivider = Helper.maxWidth * 0.03;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        double newsSize = newsItemWidth + newsDivider;
        return SizedBox(
          height: newsItemHeight,
          child: Row(
            children: [
              Expanded(
                child: ListView.separated(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final double itemPosition = index * newsSize;
                      final double difference =
                          scrollController.offset - itemPosition;
                      final double percent = 1 - (difference / newsSize);
                      double opacity = percent;
                      if (opacity > 1.0) opacity = 1.0;
                      if (opacity < 0.0) opacity = 0.0;
                      double scale = percent;
                      if (scale > 1.0) scale = 1.0;
                      if (scale < 0.0) scale = 0.0;
                      return Opacity(
                        opacity: opacity,
                        child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..scale(scale, scale),
                            child: newsItemBuilder()),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: newsDivider,
                      );
                    },
                    itemCount: 100),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget newsItemBuilder() {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Helper.maxHeight * 0.02)),
          child: CachedImage(
            fit: BoxFit.cover,
            image:
                'https://image.cnbcfm.com/api/v1/image/107149451-1668052384530-gettyimages-1243956724-AA_14102022_901353.jpeg?v=1668054353&w=1920&h=1080',
            height: newsItemHeight,
            width: newsItemWidth,
          ),
        ),
      ],
    );
  }
}
