import 'package:flutter/material.dart';

import '../../../../../../core/utils/helper.dart';
import '../../../../domain/entities/movie_keywards.dart';

class Keywords extends StatefulWidget {
  final MovieKeywords keywordsModel;

  const Keywords({super.key, required this.keywordsModel});

  @override
  State<Keywords> createState() => _KeywordsState();
}

class _KeywordsState extends State<Keywords> {
  String keywords = '';

  @override
  void initState() {
    for (int i = 0; i < widget.keywordsModel.keywords.length; i++) {
      keywords += '${widget.keywordsModel.keywords[i].name}, ';
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
