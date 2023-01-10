import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/helper.dart';
import 'package:movies_application/features/fury/presentation/screens/main_screen/main_screen.dart';
import 'package:movies_application/features/fury/presentation/screens/drawer_screen/menu_screen.dart';
import 'package:movies_application/features/fury/presentation/screens/my_lists_screen/my_lists_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/constants.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  MenuItemDetails currentItem = MenuItems.home;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        return ZoomDrawer(
            style: DrawerStyle.defaultStyle,
            controller: drawerController,
            showShadow: false,
            angle: 0.0,
            borderRadius: AppSize.s25,
            openCurve: Curves.fastOutSlowIn,
            menuBackgroundColor: Colors.black,
            slideWidth: Helper.maxWidth * 0.7,
            menuScreen: Builder(
              builder: (context) => MenuScreen(
                  currentItem: currentItem,
                  onSelectedItem: (item) {
                    currentItem = item;
                    ZoomDrawer.of(context)!.close();
                    setState(() {

                    });
                  }),
            ),
            mainScreen: getScreen());
      },
    );
  }
  Widget getScreen() {
    if(currentItem == MenuItems.home){
      return const MainScreen();
    }else if(currentItem == MenuItems.settings){
      return const SettingsScreen();
    }else if(currentItem == MenuItems.myLists){
      return const MyListsScreen();
    }else {
      currentItem = MenuItems.home;
      launchUrl(Uri.parse('https://www.themoviedb.org/talk'));
      return const MainScreen();
    }
  }
}
