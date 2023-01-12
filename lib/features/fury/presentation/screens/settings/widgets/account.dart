import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/api/movies_dio_helper.dart';
import '../../../../../../core/utils/app_values.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/strings.dart';
import '../../../../../../core/widgets/divider.dart';

class AccountWidget extends StatelessWidget {
  final double navigationArrowButtonSize;

  const AccountWidget({Key? key, required this.navigationArrowButtonSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(
          'https://www.themoviedb.org/settings/profile',
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteButtonText.withOpacity(0.15),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.s20, vertical: AppSize.s26),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.account,
                        style: Theme.of(context).textTheme.bodyText2!,
                      ),
                      MyDivider(
                        color: Colors.white,
                        paddingVertical: AppSize.s15,
                        paddingHorizontal: 0,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${MoviesDioHelper.baseImageURL}${accountDetails!.avatarPath}'),
                            radius: AppSize.s40,
                            backgroundColor: AppColors.mainColor,
                            onBackgroundImageError: (object, stackTrace) =>
                                const Icon(
                              Icons.error,
                            ),
                          ),
                          SizedBox(
                            width: AppSize.s10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                accountDetails!.userName,
                                style: Theme.of(context).textTheme.subtitle1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: AppSize.s6,
                              ),
                              Text(
                                accountDetails!.id.toString(),
                                style: Theme.of(context).textTheme.subtitle1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: navigationArrowButtonSize,
                  color: AppColors.whiteButtonText,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
