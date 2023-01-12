import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/app_fonts.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/strings.dart';

import '../../../../../core/hive/hive_helper.dart';
import '../../../../../core/utils/Colors.dart';
import '../../../../../core/utils/components.dart';
import '../../../../../core/widgets/button.dart';
import '../login_screen/login_screen.dart';

class MenuScreen extends StatelessWidget {
  final MenuItemDetails currentItem;
  final ValueChanged<MenuItemDetails> onSelectedItem;

  const MenuScreen({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          ...MenuItems.menuItemList
              .map((e) => buildMenuItem(e, context)),
          SizedBox(
            height: AppSize.s10,
          ),
          DefaultButton(
            fun: () {
              signOut(context: context,);
            },
            text: AppStrings.signOut,
            backgroundColor: AppColors.secondMainColor,
            textColor: AppColors.whiteButtonText,
            height: AppSize.s50,
            fontSize: 20,
            borderRadius: 0,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void signOut({
    required BuildContext context,
  }) {
    HiveHelper.deleteAccountDetails();
    HiveHelper.deleteSessionId();
    Components.navigateTo(context, const LoginScreen());
  }

  Widget buildMenuItem(MenuItemDetails item,
      BuildContext context,) {
    return ListTile(
      selectedTileColor: AppColors.selectedTileColor,
      selected: currentItem == item,
      minLeadingWidth: AppSize.s20,
      leading: Icon(
        item.icon,
        color: Colors.white,
        size: AppFontSize.s24,
      ),
      title: Text(
        item.title,
        style: Theme
            .of(context)
            .textTheme
            .bodyText2,
      ),
      onTap: () {
        onSelectedItem(item);
      },
    );
  }
}

class MenuItemDetails {
  final String title;
  final IconData icon;

  const MenuItemDetails({
    required this.title,
    required this.icon,
  });
}

class MenuItems {
  static const MenuItemDetails home = MenuItemDetails(
    title: AppStrings.home,
    icon: Icons.home,
  );

  static const MenuItemDetails myLists = MenuItemDetails(
    title: AppStrings.myLists,
    icon: Icons.list,
  );

  static const MenuItemDetails settings = MenuItemDetails(
    title: AppStrings.settings,
    icon: Icons.settings,
  );

  static const MenuItemDetails support = MenuItemDetails(
    title: AppStrings.support,
    icon: Icons.help,
  );

  static const menuItemList = <MenuItemDetails>[
    home,
    myLists,
    settings,
    support,
  ];
}
