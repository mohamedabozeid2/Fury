import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/drawer_icon_button.dart';

import '../../../../../core/hive/hive_helper.dart';
import '../../../../../core/utils/components.dart';
import '../../../../../core/widgets/button.dart';
import '../login_screen/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  // final ZoomDrawerController drawerController;

  const SettingsScreen({
    super.key,
    // required this.drawerController,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerIconButton(),
      ),
      body: Column(
        children: [

          DefaultButton(
            fun: () {
              signOut();
            },
            text: AppStrings.signOut,
            height: 100,
            fontSize: 20,
            borderRadius: 0,
          )
        ],
      ),
    );
  }

  void signOut() {
    HiveHelper.deleteAccountDetails();
    HiveHelper.deleteSessionId();
    Components.navigateTo(context, const LoginScreen());
  }
}
