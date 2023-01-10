import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/core/widgets/text_field.dart';

class SearchBar extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.maxHeight * 0.08,
      decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(AppSize.s20)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              // width: Helper.getScreenWidth(context: context)*0.5,
              // height: Helper.getScreenHeight(context: context)*0.05,
              child: DefaultTextField(
                context: context,
                borderColor: Colors.transparent,
                controller: searchController,
                cursorColor: Colors.white,
                hintStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: AppColors.textWhiteColor
                ),
                contentStyle: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: AppColors.greyColor),
                type: TextInputType.text,
                label: 'Search...',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
