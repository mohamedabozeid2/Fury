import 'package:flutter/material.dart';
import 'package:movies_application/features/fury/domain/entities/tv_keywords.dart';

import '../../../../../../core/utils/helper.dart';
import '../../../../domain/entities/movie_keywards.dart';

class Keywords extends StatefulWidget {
  final bool isMovie;
  final MovieKeywords? movieKeywordsModel;
  final TVKeywords? tvKeywordsModel;

  const Keywords({
    super.key,
    this.movieKeywordsModel,
    this.tvKeywordsModel,
    required this.isMovie,
  });

  @override
  State<Keywords> createState() => _KeywordsState();
}

class _KeywordsState extends State<Keywords> {
  String keywords = '';

  @override
  void initState() {
    if (widget.isMovie) {
      if(widget.movieKeywordsModel!.keywords.isEmpty){
        keywords += "No data available";
      }else{
        for (int i = 0; i < widget.movieKeywordsModel!.keywords.length; i++) {
          keywords += '${widget.movieKeywordsModel!.keywords[i].name}, ';
        }
      }
    } else {
      if(widget.tvKeywordsModel!.keywords.isEmpty){
        keywords += 'No data available';
      }else{
        for (int i = 0; i < widget.tvKeywordsModel!.keywords.length; i++) {
          keywords += '${widget.tvKeywordsModel!.keywords[i].name}, ';
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Helper.maxHeight * 0.01,
        ),
        Text(
          keywords,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
