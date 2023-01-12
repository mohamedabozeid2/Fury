import 'package:flutter/material.dart';
import 'package:movies_application/core/utils/app_values.dart';
import 'package:movies_application/core/utils/strings.dart';
import 'package:movies_application/core/widgets/drawer_icon_button.dart';
import 'package:movies_application/features/fury/presentation/screens/settings/widgets/account.dart';
import 'package:movies_application/features/fury/presentation/screens/settings/widgets/single_settings_item_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/app_fonts.dart';

class SettingsScreen extends StatefulWidget {
  final double navigationArrowButtonSize = AppFontSize.s26;

  SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppHeight.h80,
        title: Row(
          children: const [
            DrawerIconButton(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.s20,
                vertical: AppSize.s20,
              ),
              child: Row(
                children: [
                  Text(
                    AppStrings.settings,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ),
            AccountWidget(
              navigationArrowButtonSize: widget.navigationArrowButtonSize,
            ),
            SingleSettingsItemBuilder(
              navigationArrowButtonSize: widget.navigationArrowButtonSize,
              icon: Icons.newspaper,
              title: AppStrings.terms,
              color: Colors.orange,
              navigationFunction: () {
                launchUrl(Uri.parse('https://www.themoviedb.org/terms-of-use'));
              },
            ),
            SingleSettingsItemBuilder(
              navigationArrowButtonSize: widget.navigationArrowButtonSize,
              icon: Icons.info,
              title: AppStrings.aboutUs,
              color: Colors.blue,
              navigationFunction: () {
                launchUrl(Uri.parse('https://www.themoviedb.org/about'));
              },
            ),
            SingleSettingsItemBuilder(
              navigationArrowButtonSize: widget.navigationArrowButtonSize,
              icon: Icons.call,
              title: AppStrings.contactUs,
              color: Colors.green,
              navigationFunction: () {
                launchUrl(Uri.parse(
                    'https://www.themoviedb.org/about/staying-in-touch'));
              },
            ),
            SingleSettingsItemBuilder(
              navigationArrowButtonSize: widget.navigationArrowButtonSize,
              icon: Icons.privacy_tip,
              title: AppStrings.privacyPolicy,
              color: Colors.yellow,
              navigationFunction: () {
                launchUrl(
                    Uri.parse('https://www.themoviedb.org/privacy-policy'));
              },
            ),
            // SingleSettingsItemBuilder(
            //   navigationArrowButtonSize: widget.navigationArrowButtonSize,
            //   icon: Icons.call,
            //   title: AppStrings.contactUs,
            //   color: Colors.green,
            //   navigationFunction: () {},
            // ),

          ],
        ),
      ),
    );
  }


}
