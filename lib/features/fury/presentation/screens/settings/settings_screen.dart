import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/strings.dart';

import '../../../../../core/hive/hive_helper.dart';
import '../../../../../core/utils/components.dart';
import '../../../../../core/widgets/button.dart';
import '../login_screen/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }

  void signOut() {
    HiveHelper.deleteAccountDetails();
    Components.navigateTo(context, const LoginScreen());
  }
}
