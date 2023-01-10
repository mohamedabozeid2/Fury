import 'package:flutter/material.dart';

import '../../../../../../core/utils/Colors.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../../../core/utils/app_values.dart';
import '../../../../../../core/utils/components.dart';
import '../../search_screen/search_screen.dart';

class SearchIconButton extends StatelessWidget {
  const SearchIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Components.slideNavigateTo(context, SearchScreen());
      },
      child: Container(
        padding: EdgeInsets.all(AppSize.s12),
        decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(AppSize.s20)),
        child: Icon(Icons.search, size: AppFontSize.s24,),
      ),
    );
  }
}
